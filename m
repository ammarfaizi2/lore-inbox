Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131477AbQLJU5M>; Sun, 10 Dec 2000 15:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131611AbQLJU5C>; Sun, 10 Dec 2000 15:57:02 -0500
Received: from www.lahn.de ([213.61.112.58]:34864 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S131477AbQLJU4x>;
	Sun, 10 Dec 2000 15:56:53 -0500
Date: Fri, 8 Dec 2000 07:16:03 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: pmhahn@titan.lahn.de
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: automount doesn't unmount
Message-ID: <Pine.LNX.4.21.0012080704460.12565-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm using the kernel automounter to mount several cdrom's and partitions
on my smp-box. When the mount expires they aren't automatically
unmounted.
Forcing a 'kill -SIGUSR1 `pidof automount`' works for some devices, but
others stay.

$ umount /auto/install 
umount: /auto/install: device is busy

$ fuser -v /auto/install
                     USER        PID ACCESS COMMAND
/auto/install        root     kernel mount  /auto/install

$ lsof | grep /auto/install
doesn't print anything

Is their a way to find out why the device is still busy?

$ uname -a
Linux titan 2.4.0-test11 #1 SMP Mon Nov 20 21:39:42 CET 2000 i686 unknown
$ mount --version
mount: mount-2.10q
$ /usr/sbin/automount --version
Linux automount version 3.1.7

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
