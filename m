Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267119AbSLQX0A>; Tue, 17 Dec 2002 18:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbSLQX0A>; Tue, 17 Dec 2002 18:26:00 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4820 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267119AbSLQXZ6>;
	Tue, 17 Dec 2002 18:25:58 -0500
Date: Tue, 17 Dec 2002 15:28:58 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: eric lin <fsshl@centurytel.net>
cc: Bob Miller <rem@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52 compile error
In-Reply-To: <3E00231C.8020702@centurytel.net>
Message-ID: <Pine.LNX.4.33L2.0212171527070.17648-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2002, eric lin wrote:

| in the Input device suppoort
| I did not see Config_inout in make menuconfig, so I suppose is first
| item(if I am wrong please notify me)

It's "Input device support", immediately after Telephony Support
and just before Character devices.

| them make dep, meke clean, make modules
| then it terminate some other error
|
|   gcc -Wp,-MD,fs/intermezzo/.inode.o.d -D__KERNEL__ -Iinclude -Wall
| -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
| -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic
| -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE
| -DKBUILD_BASENAME=inode -DKBUILD_MODNAME=intermezzo   -c -o
| fs/intermezzo/inode.o fs/intermezzo/inode.c
| make[2]: *** No rule to make target `fs/intermezzo/io_daemon.s', needed
| by `fs/intermezzo/io_daemon.o'.  Stop.
| make[1]: *** [fs/intermezzo] Error 2
| make: *** [fs] Error 2

Just remove io_daemon.o from the fs/intermezzo/Makefile .

-- 
~Randy

