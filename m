Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbSLPSs0>; Mon, 16 Dec 2002 13:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbSLPSrs>; Mon, 16 Dec 2002 13:47:48 -0500
Received: from air-2.osdl.org ([65.172.181.6]:52369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267043AbSLPSqn>;
	Mon, 16 Dec 2002 13:46:43 -0500
Date: Mon, 16 Dec 2002 10:49:58 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Where is this printk?
In-Reply-To: <200212161938.28306.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.33L2.0212161049090.5099-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Marc-Christian Petersen wrote:

| Hi all,
|
| does anyone know where this is printed out in kernel source?
|
| Linux version 2.4.20 (root@codeman) (gcc version 2.95.4 20011002 (Debian
| prerelease)) #1 Mon Dec 16 16:54:44 CET 2002
| BIOS-provided physical RAM map:
|  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
|  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
| ...
|
| I only want to know where the first line is printed out (that is a dmesg
| output). I want to put in a printk just before the first line.
|
| I thought somewhere in arch/$arch/kernel/setup.c but I cannot figure out
| where.

Nope, it's in linux/init/main.c, line 357 in 2.4.20:

	printk(linux_banner);

and linux_banner is in linux/init/version.c.

-- 
~Randy

