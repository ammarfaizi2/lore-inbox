Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFBCd>; Fri, 5 Jan 2001 20:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131452AbRAFBCX>; Fri, 5 Jan 2001 20:02:23 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:33114 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129324AbRAFBCN>; Fri, 5 Jan 2001 20:02:13 -0500
Date: Sat, 6 Jan 2001 03:09:15 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Tim Wright <timw@splhi.com>
cc: Torrey Hoffman <torrey.hoffman@myrio.com>, Sven Koch <haegar@cut.de>,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <20010105152345.A2100@scutter.sequent.com>
Message-ID: <Pine.LNX.4.21.0101060306210.6317-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I had a similar situation except I was more interested in the performance
> difference. Went from ~4MB/s with the 430HX controller to ~12.5MB/s with
> the promise. This on an old Pentium system.

The network is 10 mbit, so 4 MB/sec is no good in this case.
I've got the thing running, with (ibm)setmax. Don't hang the disk in a
machine that does handle > 32 GB, because it will screw the limit the
setmax just set.

> > > I solved the problem by getting a Promise Ultra 100 controller
> > > and putting the drive on that. Works perfectly under Linux 
> > > Mandrake 2.2.17-mdk-21 - it shows up as /dev/hde.  They are
> > > cheap controllers if you don't get the RAID version.
> > 
> > Thanx.. Will try that. New machine costs more.
> >  
> 
> Vanilla 2.2 kernels don't have this support (at least not as on 2.2.18).
> If you're not running Mandrake, grab Andre Hedrick's excellent ide patch.

Already installed :)

> One thing you may like to know. If you want the drives attached to the new
> controller to be /dev/hda..., then edit lilo.conf and add
> 	append="pci=reverse"
> to your patched kernel entry. Oh, and if you ever need to bootstrap one of
> these puppies with a kernel that doesn't have the drivers, you can use
> 	append="ide0=0xe000,0xd802 ide1=0xd400,0xd002"
> to be able to access the drive attached to the Promise controller using the
> standard ide driver.
> 
> Hope this helps.

Thanx. If I get anymore problems I'll switch to a Promise controller. 2
days to setup a plain Linux box is a bit much.. 

Main problem I've had is that the software clipping bugs, or that my BIOS
in teh newer machine screws things up.

> Tim

	Regards,

		
		Igmar


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
