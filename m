Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316389AbSEOO50>; Wed, 15 May 2002 10:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316388AbSEOO4k>; Wed, 15 May 2002 10:56:40 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:44807 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S316389AbSEOO42>; Wed, 15 May 2002 10:56:28 -0400
Message-Id: <200205151454.g4FEsM990428@aslan.scsiguy.com>
To: Dana Lacoste <dana.lacoste@peregrine.com>
cc: linux-kernel@vger.kernel.org, aic7xxx@freebsd.org
Subject: Re: AIC7xxx in 2.4.19-pre8? 
In-Reply-To: Your message of "15 May 2002 09:49:12 EDT."
             <1021470553.28001.37.camel@dlacoste.ottawa.loran.com> 
Date: Wed, 15 May 2002 08:54:22 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>(Kernel version is 2.4.19-pre8.  Let me know if you want more info :)
>
>(Motherboard is Nexcom Peak 632 : 440BX with Adaptec 7890U2)
>
>I'm getting (over and over and over and over) the message from line
>1854 of drivers/scsi/aic7xxx/aic7xxx_pci.c :
>
>scsi0: PCI error Interrupt at seqaddr = 0x8
>scsi0: PCI error Interrupt at seqaddr = 0x9
>
>(0x9 is more common, no pattern detected between 0x8 and 0x9)
>
>It's interlaced with :
>scsi0: Received a Target Abort
>
>which means the status1 flag RTA was set, but I'm now officially out
>of my league :)

Hmm.  The aic7xxx chip could have botched a master transaction somehow,
but that's still hard to say.  Can you have the driver dump out its
chip state (call ahc_dump_card_state(ahc) from within the pci interrupt
handler) to get some additional information?

>This box was going fine till this morning (we upgraded from 2.4.18
>last night) and a second box we did the same thing to also had the
>same problem, so it looks like a kernel issue somehow, not just
>faulty hardware.  Retrograding to 2.4.18 caused the problem to go
>away.

How much memory is in the box?  What version of the aic7xxx driver
were you using under 2.4.18?

--
Justin
