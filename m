Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWFUUrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWFUUrz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWFUUrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:47:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51672 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932232AbWFUUry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:47:54 -0400
Date: Wed, 21 Jun 2006 13:47:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Jeff Dike <jdike@addtoit.com>
cc: linux-kernel@vger.kernel.org
Subject: UML/x86_64 broke on debian etch
Message-ID: <Pine.LNX.4.64.0606211345030.21866@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried to use UML to do the page migration testing for x86_64 but ....

christoph@graphe:/usr/src/linux-2.6.17-uml$ make clean
  CLEAN   .tmp_versions
christoph@graphe:/usr/src/linux-2.6.17-uml$ make all ARCH=um
  SYMLINK arch/um/include/kern_constants.h
  SYMLINK arch/um/include/sysdep
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/um/Kconfig
#
# using defaults found in .config
#
  CHK     arch/um/include/uml-config.h
  UPD     arch/um/include/uml-config.h
  CC      arch/um/sys-x86_64/user-offsets.s
  CHK     arch/um/include/user_constants.h
  CHK     include/linux/version.h
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/um/kernel/asm-offsets.s
In file included from include/asm/timex.h:14,
                 from include/linux/timex.h:61,
                 from include/linux/sched.h:11,
                 from arch/um/include/sysdep/kernel-offsets.h:3,
                 from arch/um/kernel/asm-offsets.c:1:
include/asm/processor.h:74: error: 'CONFIG_X86_L1_CACHE_SHIFT' undeclared 
here (not in a function)
include/asm/processor.h:74: error: requested alignment is not a constant
include/asm/processor.h:229: error: requested alignment is not a constant
In file included from include/linux/sched.h:12,
                 from arch/um/include/sysdep/kernel-offsets.h:3,
                 from arch/um/kernel/asm-offsets.c:1:
include/linux/jiffies.h:18:5: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:20:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:22:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:24:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:26:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:28:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:30:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:33:3: error: #error You lose.
include/linux/jiffies.h:210:31: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:210:31: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:210:31: error: division by zero in #if
include/linux/jiffies.h:210:31: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:210:31: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:210:31: error: division by zero in #if
include/linux/jiffies.h:210:31: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:210:31: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:210:31: error: division by zero in #if
include/linux/jiffies.h:210:31: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:210:31: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:210:31: error: division by zero in #if
include/linux/jiffies.h:210:31: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:210:31: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:210:31: error: division by zero in #if

....

