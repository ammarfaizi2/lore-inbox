Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130107AbRAaEX2>; Tue, 30 Jan 2001 23:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbRAaEXS>; Tue, 30 Jan 2001 23:23:18 -0500
Received: from quechua.inka.de ([212.227.14.2]:21354 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130107AbRAaEXG>;
	Tue, 30 Jan 2001 23:23:06 -0500
Date: Wed, 31 Jan 2001 05:23:05 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.4.1] mkreiserfs on loopdevice freezes kernel
Message-ID: <20010131052305.A828@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

if I run mkreiserfs on a 32megablocks /dev/loop0 it will lock up while
generating the journaling information. Sometimes at 20% sometimes at 60%.
Since mkreiserfs is not using the kernel module i guess this is a loop
device problem in 2.4.1 kernels.

There is no dmesg message at the lookup. mkreiserfs is in state 'D'. The
system issomewhat useable (X) but some programs just lock in syscalls (no su
or login possible).

If I run losetup -d /dev/loop0 on that device i will get a message that it
is busy, but the program will not return enymore. It is in 'D' also.

This is an unecncrypted loop device on a ext2 filesystem on a AIC-7861. Loop
is autoloaded as a module.

Wanted to try reiserfs with some verbose debugging for some time. Well,
perhaps md is my friend...

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
