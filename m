Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130271AbRCGG2H>; Wed, 7 Mar 2001 01:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130425AbRCGG15>; Wed, 7 Mar 2001 01:27:57 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:5664 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130271AbRCGG1t>;
	Wed, 7 Mar 2001 01:27:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Frank Davis <fdavis112@juno.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac13 make modules_install error 
In-Reply-To: Your message of "Wed, 07 Mar 2001 00:04:08 CDT."
             <381411025.983941453617.JavaMail.root@web124-wra.mail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Mar 2001 17:26:57 +1100
Message-ID: <1534.983946417@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001 00:04:08 -0500 (EST), 
Frank Davis <fdavis112@juno.com> wrote:
>make[2]: Entering directory '/usr/src/linux/drivers/atm'
>mkdir -p /lib/modules/2.4.2-ac13/kernel/$(shell ($CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
>/bin/sh: CONFIG_SHELL: command not found
>/bin/sh: TOPDIR: command not found

Against 2.4.2-ac13.  You need the same patch on 2.4.3-pre2.

Index: 2.26/Rules.make
--- 2.26/Rules.make Tue, 06 Mar 2001 13:01:59 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1.1.2 644)
+++ 2.26(w)/Rules.make Wed, 07 Mar 2001 17:25:40 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1.1.2 644)
@@ -150,7 +150,7 @@ endif
 #
 ALL_MOBJS = $(filter-out $(obj-y), $(obj-m))
 ifneq "$(strip $(ALL_MOBJS))" ""
-MOD_DESTDIR ?= $(shell $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
+MOD_DESTDIR := $(shell $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
 endif
 
 unexport MOD_DIRS

