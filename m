Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280956AbRLDRxL>; Tue, 4 Dec 2001 12:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281042AbRLDRvy>; Tue, 4 Dec 2001 12:51:54 -0500
Received: from air-1.osdl.org ([65.201.151.5]:52488 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S281061AbRLDRvO>;
	Tue, 4 Dec 2001 12:51:14 -0500
Date: Tue, 4 Dec 2001 09:47:01 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Michael Zhu <apiggyjj@yahoo.ca>
cc: Tyler BIRD <BIRDTY@uvsc.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Insmod problems
In-Reply-To: <20011204170642.78487.qmail@web20209.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L2.0112040946130.18921-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, Michael Zhu wrote:

| I've define these two when I compile the module. The
| command line is:
|
| gcc -D_KERNEL_ -DMODULE -c hello.c

Check the spelling of "__KERNEL__".

~Randy

| --- Tyler BIRD <BIRDTY@uvsc.edu> wrote:
| > You need to define the __KERNEL__ and MODULE symbols
| >
| > #define __KERNEL__
| > #define MODULE
| >
| >
| > >>> Nav Mundi <nmundi@karthika.com> 12/04/01 09:33AM
| > >>>
| > What are we doing wrong? - Nav & Michael
| > **************************************************
| >
| > hello.c Source:
| >
| > #include "/home/mzhu/linux/include/linux/config.h"
| > /*retrieve the CONFIG_* macros */
| > #if defined(CONFIG_MODVERSIONS) &&
| > !defined(MODVERSIONS)
| > #define MODVERSIONS  /* force it on */
| > #endif
| >
| > #ifdef MODVERSIONS
| > #include
| > "/home/mzhu/linux/include/linux/modversions.h"
| > #endif
| >
| > #include "/home/mzhu/linux/include/linux/module.h"
| >
| > int init_module(void)  { printk("<1>Hello,
| > world\n");  return 0; }
| > void cleanup_module(void) { printk("<1>Goodbye cruel
| > world\n"); }
| >
| > Output:
| >
| > #>gcc -D_KERNEL_ -DMODULE -c hello.c
| >
| > [This builds the hello.o file. ]
| >
| > #>insmod hello.o
| >
| > hello.o : unresolved symbol printk
| > hello.o : Note: modules without a GPL compatible
| > license cannot use
| > GPONLY_symbols

