Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273252AbTG3StS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273253AbTG3StS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 14:49:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:21376 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S273252AbTG3StR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 14:49:17 -0400
Date: Wed, 30 Jul 2003 14:50:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Studying MTD <studying_mtd@yahoo.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, agoddard@purdue.edu,
       joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test1 : modules not working
In-Reply-To: <20030730180201.78497.qmail@web20509.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0307301440170.1250@chaos>
References: <20030730180201.78497.qmail@web20509.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003, Studying MTD wrote:

> I am curious what is the minimum kernel source tree is
> required to build external modules.
>
> I dont want to touch my kernel , i want to make
> another directory same 'module_test' and want to copy
> only required minimum kernel Source tree with modified
> scripts's Makefile and kbuild Makefile to build "Hello
> World".
>
> Please help me.
>
> Thanks.

For Intel:

/usr/src/linux-2.6.0
/usr/src/linux-2.6.0/include/linux/*
/usr/src/linux-2.6.0/include/asm-generic/*
/usr/src/linux-2.6.0/include/asm-i386/*
/usr/src/linux-2.6.0/include/asm # Symlink to above
/usr/src/linux-2.6.0/include/math-emu/*
/usr/src/linux-2.6.0/include/net/*
/usr/src/linux-2.6.0/include/pcmcia/*
/usr/src/linux-2.6.0/include/scsi/*
/usr/src/linux-2.6.0/include/video/*


When you compile modules, you use -I/usr/src/linux-2.6.0/include
...on the command line. Remember to -D__KERNEL__ and -DMODULE.

That's all you need for 2.6.0 modules...




Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

