Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbTABPp1>; Thu, 2 Jan 2003 10:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTABPp1>; Thu, 2 Jan 2003 10:45:27 -0500
Received: from air-2.osdl.org ([65.172.181.6]:39110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262296AbTABPpB>;
	Thu, 2 Jan 2003 10:45:01 -0500
Date: Thu, 2 Jan 2003 07:50:31 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: SZALAY Attila <sasa@pheniscidae.tvnetwork.hu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.54
In-Reply-To: <20030102103422.GB24116@sasa.home>
Message-ID: <Pine.LNX.4.33L2.0301020745260.22868-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003, SZALAY Attila wrote:

| I have a linking problem with 2.5.54 (and 2.5.53 too)
|
| drivers/built-in.o: In function `kd_nosound':
| drivers/built-in.o(.text+0x37923): undefined reference to 	nput_event'
| drivers/built-in.o(.text+0x3793c): undefined reference to 	nput_event'
| drivers/built-in.o: In function `kd_mksound':
| drivers/built-in.o(.text+0x379e7): undefined reference to 	nput_event'
| drivers/built-in.o: In function `kbd_bh':
| drivers/built-in.o(.text+0x385a2): undefined reference to 	nput_event'
| drivers/built-in.o(.text+0x385b0): undefined reference to 	nput_event'
| drivers/built-in.o(.text+0x385c1): more undefined references to 	nput_event' follow
| drivers/built-in.o: In function `kbd_connect':
| drivers/built-in.o(.text+0x389e3): undefined reference to 	nput_open_device'
| drivers/built-in.o: In function `kbd_disconnect':
| drivers/built-in.o(.text+0x389ff): undefined reference to 	nput_close_device'
| drivers/built-in.o: In function `kbd_init':
| drivers/built-in.o(.init.text+0x2ae1): undefined reference to 	nput_register_handler'
| make[1]: *** [vmlinux] Error 1

Yes, unfortunately this is a well-known problem.
See kernel.bugzilla.org # 126 and # 164.

You need to have CONFIG_INPUT=y, not =m.
Alternatively you could have CONFIG_VT=n if that
would work for you (not likely).

| CONFIG_INPUT=m
| CONFIG_VT=y
| CONFIG_VT_CONSOLE=y


HTH.
-- 
~Randy

