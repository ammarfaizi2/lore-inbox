Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUAGW1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 17:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUAGW1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 17:27:23 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27660 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265660AbUAGW1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 17:27:17 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [NEW FEATURE]Partitions on loop device for 2.6
Date: 7 Jan 2004 22:15:12 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bti0dg$7b4$1@gatekeeper.tmr.com>
References: <200312241341.23523.blaisorblade_spam@yahoo.it> <3FF5DCE8.4020008@tmr.com> <200401031905.42584.blaisorblade_spam@yahoo.it>
X-Trace: gatekeeper.tmr.com 1073513712 7524 192.168.12.62 (7 Jan 2004 22:15:12 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200401031905.42584.blaisorblade_spam@yahoo.it>,
BlaisorBlade  <blaisorblade_spam@yahoo.it> wrote:
| Alle 22:04, venerdì 2 gennaio 2004, Bill Davidsen ha scritto:
| > BlaisorBlade wrote:
| > > NEED:
| > > I have the need to loop mount files containing not plain filesystems, but
| > > whole disk images.
| > >
| > > This is especially needed when using User-mode-linux, since to run any
| > > distro installer you must partition the virtual disks(and on the host,
| > > the backing file of the disk contains a partition table).
| > >
| > > Currently this could be done by specifying a positive offset, but letting
| > > the kernel partition code handle this is better, isn't it? Would you ever
| > > accept this feature into stock kernel?
| >
| > UML is on my list of things to learn (as opposed to "try casually and
| > ignore")
| It is something a bit like VMWare. But instead of emulating hardware and 
| running an OS inside that, you run a patched Linux kernel that runs as an 
| userspace process on the host and provides a virtual machine, which must 
| access a virtual disk, which is stored on a file.
| See http://user-mode-linux.sourceforge.net/ for more info.

As noted, I tried it casually, got a kernel to boot and run, and decided
it wasn't a solution to problems I had at the time.

| > but have you considered using NBD?
| I didn't really know what it was, nor it seems useful for this "as is" (I've 
| not really checked). Maybe that sentence means that the server program could 
| do the partition parsing?

NBD = network block device

This allows a user-space program to publish a file which a kernel with
nbd enabled can mount as a device. So you should be able to run fdisk
and partition it, load stuff on it, and generally treat it like a drive.

Take a look at Documentation/nbd.txt, it may be exactly what you want to
provide a "block device" which can be on the same system using the
loopback interface.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
