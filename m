Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278261AbRJWTbo>; Tue, 23 Oct 2001 15:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278209AbRJWTb0>; Tue, 23 Oct 2001 15:31:26 -0400
Received: from [64.244.224.2] ([64.244.224.2]:27920 "EHLO klingon.active.net")
	by vger.kernel.org with ESMTP id <S278206AbRJWTbQ>;
	Tue, 23 Oct 2001 15:31:16 -0400
Date: Tue, 23 Oct 2001 15:31:47 -0400 (EDT)
From: Marques Johansson <displague@displague.com>
X-X-Sender: <displague@klingon.active.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.12 not mounting root initrd with highmem 4G enabled (686)
Message-ID: <Pine.LNX.4.33.0110231518070.5168-100000@klingon.active.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in the ac line of kernels, i have been unable to get my
kernel to "boot". it says that the initrd image was not found at 0,
and then tries to mount alternate devices (which it can not because the
ext3, and ide drivers are configured to load via initrd).

i have CONFIG_HIGHMEM, CONFIG_HIGHMEM_4G, CONFIG_CRAMFS, and
CONFIG_BLK_DEV_INITRD all set y, with CONFIG_BLK_DEV_RAM_SIZE=4096.

my initrd image is created with
mkinitrd -v -o /boot/initrd-2.4.12-ac5 /lib/modules/2.4.12-ac5 && lilo

no errors are reported at this level.. mkcramfs is v2.4.12, mkinitrd is
v1.19.

I assume this is because of the HIGHMEM option as this is the only thing I
have changed.  I have tried this on various 2.4.11 (ac), and 2.4.12 (ac)
versions.

ideas?
--
Marques Johansson
marques@displague.com


===  ALL CSH USERS PLEASE NOTE  ========================

Set the variable $LOSERS to all the people that you think are losers.  This
will cause all said losers to have the variable $PEOPLE-WHO-THINK-I-AM-A-LOSER
updated in their .login file.  Should you attempt to execute a job on a
machine with poor response time and a machine on your local net is currently
populated by losers, that machine will be freed up for your job through a
cold boot process.

