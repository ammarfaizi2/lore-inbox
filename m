Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTLSM5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTLSM4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:56:22 -0500
Received: from [217.73.129.129] ([217.73.129.129]:3300 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263468AbTLSMuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:50:32 -0500
Date: Fri, 19 Dec 2003 14:49:14 +0200
Message-Id: <200312191249.hBJCnEFp022715@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: 2.6.0: reiserfs errors: reiserfs_read_locked_inode and friends
To: sgtphou@fire-eyes.dynup.net, linux-kernel@vger.kernel.org
References: <3FE28116.3000406@fire-eyes.dynup.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

fire-eyes <sgtphou@fire-eyes.dynup.net> wrote:

fe> I have been experimenting between 2.4.23 and 2.6.0-test{5,6,7,8,9,10,11} 
fe> and now 2.6.0.
fe> Starting with -test11, I noticed often that I could not perform a 
fe> startx, and as root got permission denied trying to execute or even list 
fe> some files. I also notice this in 2.6.0. Dropping back to 2.4.23, I can 
fe> perform the mentioned actions.

fe> Dec 18 22:29:40 localhost kernel: hda: set_drive_speed_status: 
fe> status=0x58 { DriveReady SeekComplete DataRequest }
fe> Dec 18 22:29:40 localhost kernel: ide0: Drive 0 didn't accept speed 
fe> setting. Oh, well.
fe> Dec 18 22:29:40 localhost kernel: blk: queue dfd8f800, I/O limit 4095Mb 
fe> (mask 0xffffffff)
fe> Dec 18 22:29:40 localhost kernel: is_tree_node: node level 0 does not 
fe> match to the expected one 2

Sounds that somehow some blocks read by reiserfs are zero-filled.

fe> Here is what i'm passing to 2.6.0 via grub:
fe> root=/dev/hda6 ide0=autotune ide1=autotune

What if won't pass "ide0=autotune ide1=autotune" part for 2.6? Does
anything changes?

Bye,
    Oleg
