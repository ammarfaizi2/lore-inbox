Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSKLAIi>; Mon, 11 Nov 2002 19:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSKLAIi>; Mon, 11 Nov 2002 19:08:38 -0500
Received: from air-2.osdl.org ([65.172.181.6]:65170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262486AbSKLAIh>;
	Mon, 11 Nov 2002 19:08:37 -0500
Date: Mon, 11 Nov 2002 16:10:13 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
cc: <george@mvista.com>
Subject: Re: [PATCH ] POSIX clocks & timers take 10 (NOT HIGH RES)
Message-ID: <Pine.LNX.4.33L2.0211111539030.23954-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi George,

I have a couple of small comments on the latest POSIX interface
patch (take 10 -- NOT HIGH RES).

1.  arch/i386/kernel/entry.S uses nr_syscalls and the patch
removes NR_syscalls from include/asm-i386/sys.h, but
user-mode-linux needs/uses NR_syscalls.  However, I see why you
removed it from sys.h:  it's basically a dead file.
And it looks like include/linux/sys.h shouldn't have that
#define in it (should be per arch).

2.  again in arch/i386/kernel/entry.S:  the added syscall number
/*comments*/ are off by 1.

-- 
~Randy

