Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUDQSRq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbUDQSRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:17:45 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:62913 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264012AbUDQSRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:17:41 -0400
Subject: Re: 2.6.6-rc1 caused dedicated Quake 3 server to core dump
From: Christophe Saout <christophe@saout.de>
To: Stephen Lee <slee@tuxsoft.com>
Cc: linux-kernel@vger.kernel.org, steve@tuxsoft.com
In-Reply-To: <008f01c42497$10ad48f0$8119fea9@pluto>
References: <008f01c42497$10ad48f0$8119fea9@pluto>
Content-Type: text/plain
Message-Id: <1082225855.21319.29.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.6.2 
Date: Sat, 17 Apr 2004 20:17:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa, den 17.04.2004 schrieb Stephen Lee um 11:14 Uhr -0500:

> For years now, I've been running a dedicated Quake 3 server on my linux
> box.  Last night, was the first time I've ever seen a core dump with
> Quake.  2.6.5 was and is now running fine, but under 2.6.6-rc1 it core
> dumped within about 30 minutes with the attached dmesg output.

Could this be something similar to what I've been seeing?

Hmm, some days ago I compiled a program and the resulting binary was
broken. It always crashed at a certain point. I recompiled it and then
everything was fine. I've never seen this before on this machine. It is
2.6.5 patched with 2.6.5-mcsomething + some patches from
2.6.5-mmsomething (I don't remember exactly, but all of the VM changes
and driver updates, nearly everything except the CPU scheduler changes
and the actual objrmap patches). The machine was under extreme swap load
while compiling the program and that resulted in a broken binary.

I had tested another kernel before (with some 2.6.4-rc3-mmsomething
patches) and I tried to compile php and it failed because a source file
had 3*1024 bytes of nullbytes in it after unpacking the tar file. I
think the machine was swapping too.

The patches in in 2.6.6-rc1 that are actually being used on the machine
are (from jgarzik's RFT mail):

* non-exec stack support
* much better block I/O unplugging (I/O scalability)
* lots of VM work (often related to I/O or Hugh's rmap/anonvma stuff)
* queue congestion hooks
* DM, MD fixes (some related to the queue congestion/unplugging changes)
(and other patches from the unstable dm tree, but there are no other
core changes)
* reiserfs fixes and features (+ some other of Chris Mason's patches)
* readahead tweaks and fixes
* writeback tweaks
* direct-IO and AIO fixes and speed-ups

This is a IBM ThinkPad T40 and the hardware is absolutely stable. config
attached.


