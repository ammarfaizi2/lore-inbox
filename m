Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUEEA7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUEEA7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUEEA7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:59:45 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:36420 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S261186AbUEEA7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:59:42 -0400
Date: Tue, 4 May 2004 02:02:24 +0100
From: backblue <backblue@netcabo.pt>
To: "Mirko Caserta" <mirko@mcaserta.com>, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, mirko@mcaserta.com
Subject: Re: [ERROR] in ini9100.c scsi driver
Message-Id: <20040504020224.28017aad@fork.ketic.com>
In-Reply-To: <opr7gu9q0apsnffn@mail.mcaserta.com>
References: <20040502212548.2fe2370a@fork.ketic.com>
	<opr7gu9q0apsnffn@mail.mcaserta.com>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2004 00:59:38.0308 (UTC) FILETIME=[3D6B3840:01C4323C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I "remember" to see the CHANGELOG, and i have found this!

<akpm@osdl.org>
	[PATCH] ini9100u build fix
	
	From: Christoph Hellwig <hch@infradead.org>
	
	- Remove dead forward declarations
	
	- Fix compilation of the interrupt handler.


One of this ones it's the maintainer, do you know, if this patch that you have send it to me, have been merged in to the kernel?

Tks for the patch! :)

On Tue, 04 May 2004 10:30:52 +0200
"Mirko Caserta" <mirko@mcaserta.com> wrote:

> 
> Try this patch some clever guy sent to the list a couple days ago. I had  
> the same issue and this patch fixed it.
> 
> This is against 2.6.5. Who takes care of merging this scsi driver into the  
> mainstream kernel? I couldn't find anyone in the MAINTAINERS file. Thanks.
> 
> Mirko
> 
> On Sun, 2 May 2004 21:25:48 +0100, backblue <backblue@netcabo.pt> wrote:
> 
> > Hi,
> >
> > I'm with linux-2.6.5, i have re-compiled the kernel, to get suport to  
> > another scsi controler in my workstation. Attached it's the all dmesg  
> > file, and here it's the debug output that the kernel show's me! i dont  
> > know who have changed the kernel to have new DMA suporte, if someone  
> > know's say me please, so i can mail him directly.
> >
> >
> >
> > scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
> >         <Adaptec 2940A Ultra SCSI adapter>
> >         aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs
> >
> > (scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 8)
> >   Vendor: PIONEER   Model: DVD-ROM DVD-303F  Rev: 2.00
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> > PCI: Enabling device 0000:01:09.0 (0006 -> 0007)
> > PCI: Unable to reserve mem region #2:1000@e3001000 for device  
> > 0000:01:09.0
> > aic7xxx: <Adaptec AHA-2940A Ultra SCSI host adapter> at PCI 1/9/0
> > aic7xxx: I/O ports already in use, ignoring.
> > i91u: PCI Base=0xC000, IRQ=11, BIOS=0xFF000, SCSI ID=2
> > i91u: Reset SCSI Bus ...
> > ERROR: SCSI host `INI9100U' has no error handling
> > ERROR: This is not a safe way to run your SCSI host
> > ERROR: The error handling must be added to this driver
> > Call Trace:
> >  [<c02ad5bc>] scsi_host_alloc+0x2ac/0x2c0
> >  [<c02e8653>] init_tulip+0x2b3/0x2d0
> >  [<c02ad5ee>] scsi_register+0x1e/0x70
> >  [<c02e7715>] i91u_detect+0x1b5/0x2c0
> >  [<c05081a0>] init_this_scsi_driver+0x40/0x100
> >  [<c04ee7fc>] do_initcalls+0x2c/0xc0
> >  [<c01297b2>] init_workqueues+0x12/0x60
> >  [<c01030cf>] init+0x2f/0x120
> >  [<c01030a0>] init+0x0/0x120
> >  [<c0106d31>] kernel_thread_helper+0x5/0x14
> >
> > scsi1 : Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g
> >   Vendor: YAMAHA    Model: CRW8424S          Rev: 1.0j
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> > sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
> > Uniform CD-ROM driver Revision: 3.20
> > Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> > sr1: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
> > Attached scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0
> > Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
> > Attached scsi generic sg1 at scsi1, channel 0, id 1, lun 0,  type 5
> >
> > Tks
> 
> 
