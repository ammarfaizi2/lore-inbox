Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbTIEReS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265731AbTIEReS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:34:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:28608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265768AbTIEReN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:34:13 -0400
Date: Fri, 5 Sep 2003 10:28:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: dead_email@nospam-mail.org
Cc: jpd_hp_linux_kernel@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test4: mpspec.h:6:25: mach_mpspec.h: Missing file
Message-Id: <20030905102840.59116fc5.rddunlap@osdl.org>
In-Reply-To: <20030904220233.79882.qmail@web60108.mail.yahoo.com>
References: <20030904220233.79882.qmail@web60108.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 15:02:33 -0700 (PDT) j d <jpd_hp_linux_kernel@yahoo.com> wrote:

| Hi. 
| I'm trying to build a (add-on) module 
| on a machine booted from a 2.6-test4 kernel,
| And keep running into this error. I've 
| included a sample program , and gcc command
| line.
| 
| I built the kernel:
| 
| make defconfig; 
| 
| It is a 2W SMP (Compaq ML850)
| couple minor modes like enet & SCSI device
| make
| My general question is, should I include the 
| 
| -I/work/src/<build>/include/asm-i386/mach-generic/mach_mpspec.h
| 
| in my gcc command line or is my build area incorrect
| is
| some way that the correct mpspec.h file can't be found

See linux/Documentation/modules.txt and Documentation/kbuild/makefiles.txt
for how to do this properly.  Basically put your source and Makefile
in a subdir, then use this command and it builds without that error.
(Your source had a few other warnings, but it does build this way.)

Here's the Makefile that I used, with usage info in it:

# makefile for addonmodule
# Randy Dunlap, 2003-02-21
# usage:
# cd /path/to/kernel/source && make SUBDIRS=/path/to/source/addonmodule/ modules

obj-m := addonmodule.o



--
~Randy
