Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUC3Vjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUC3Vjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:39:54 -0500
Received: from mail.tmr.com ([216.238.38.203]:19461 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261313AbUC3Vju convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:39:50 -0500
Date: Tue, 30 Mar 2004 16:37:44 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
cc: Administrator@smtp.paston.co.uk,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NEW FEATURE]Partitions on loop device for 2.6
In-Reply-To: <010a01c415a4$26fc1110$d100000a@sbs2003.local>
Message-ID: <Pine.LNX.3.96.1040330162602.7288C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, BlaisorBlade wrote:

> Alle 22:04, venerdì 2 gennaio 2004, Bill Davidsen ha scritto:
> > BlaisorBlade wrote:
> > > NEED:
> > > I have the need to loop mount files containing not plain filesystems, but
> > > whole disk images.
> > >
> > > This is especially needed when using User-mode-linux, since to run any
> > > distro installer you must partition the virtual disks(and on the host,
> > > the backing file of the disk contains a partition table).
> > >
> > > Currently this could be done by specifying a positive offset, but letting
> > > the kernel partition code handle this is better, isn't it? Would you ever
> > > accept this feature into stock kernel?
> >
> > UML is on my list of things to learn (as opposed to "try casually and
> > ignore")
> It is something a bit like VMWare. But instead of emulating hardware and 
> running an OS inside that, you run a patched Linux kernel that runs as an 
> userspace process on the host and provides a virtual machine, which must 
> access a virtual disk, which is stored on a file.
> See http://user-mode-linux.sourceforge.net/ for more info.
> > but have you considered using NBD?
> I didn't really know what it was, nor it seems useful for this "as is" (I've 
> not really checked). Maybe that sentence means that the server program could 
> do the partition parsing?
> -- 
> cat <<EOSIGN
> Paolo Giarrusso, aka Blaisorblade
> Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
> EOSIGN

No, I had in mind that using NBD you might be able to do partitions on the
network device, depending on just how much it looks like a real block
device. And since it looks as if just about anything can be a backing
store for NBD I thought it might be useful to export the file or partition
being used as the pseudo-drive and letting the UML kernel then do
partitions on it as it will. While a loopback mount looks like a partition
more than a disk, I believe the NBD actually looks like a drive.

I played with NBD long ago when it was new stuff, but what I did would
have worked as well on a partition or a device, so I have nothing to offer
but the suggestion.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

