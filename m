Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265276AbUETUYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUETUYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 16:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbUETUYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 16:24:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9122 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265276AbUETUYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 16:24:32 -0400
Date: Thu, 20 May 2004 17:25:24 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: wvhulzen@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: SCSI failure resulting in kernel panic
Message-ID: <20040520202524.GC20953@logos.cnet>
References: <200405172052.i4HKqUqf021980@palantir.eregion.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405172052.i4HKqUqf021980@palantir.eregion.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 10:52:30PM +0200, Wilfried v. Hulzen wrote:
> [1.] SCSI failure resulting in kernel panic
> [2.] Full description of the problem/report:
>      When executing a disc-intensive command:
> 	( cd /var/tmp/. ; tar -cf - . ) | tar -xvf -
>      in a newly formatted partition on a scsi disc, where /var/tmp. resides on
>      a IDE disc partition, results almost immediately in the following panic
>      screen. Note: /var/tmp/. are on /dev/hda5, target partition is /dev/sdb1
>      Extract from boot information:
>      hda: Maxtor 6Y160L0, ATA DISK drive
>      scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>              <Adaptec 2940 Ultra2 SCSI adapter>
> 	     aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
>      sdb:
> 	(scsi0:A:3): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
> 	  Vendor: QUANTUM   Model: ATLAS10K3_18_WLS  Rev: 020W
> 	  Type:   Direct-Access                      ANSI SCSI revision: 03
> 
> ============================================================================
> scsi0:A:3:0: Target did not send an IDENTITY message. LASTPHASE = 0xe0.
> scsi0:A:3:0: Protocol violation in Message-in phase. Attempting to abort.
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  Printing eip:
> c0232ed0
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0232ed0>]     Not tainted
> EFLAGS: 00010046
> eax: 00000001   ebx: 00000007   ecx: 00000001   edx: 0000000d
> esi: dfe2e800   edi: 00000000   ebp: 000000a0   esp: c03abe88
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c03ab000)
> Stack: dfe2e800 00000000 0000000d 00000001 00000041 00000001 dfe130b8 def13618
>        000000ff 00000041 00000003 00000000 00000000 dfe13000 41410330 00000007
>        00000003 dfe10008 00000003 00000000 00000241 00000001 dfe26e80 00000001
> Call Trace:    [<c0217b68>] [<c02307fb>] [<0c22f2d6>] [<c022ced9>] [<c0108fc9>]
>   [<c01091e8>] [<c01053d0>] [<c010bba8>] [<c01053d0>] [<c01053f9>] [<c0105492>]
>   [<c0105000>]
> 
> Code: 8b 07 0f b6 40 1b 89 44 24 20 e9 77 ff ff ff 89 34 24 31 c0
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing

Wilfried, 

Can you please run this through ksymoops?
