Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946540AbWKAKJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946540AbWKAKJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946123AbWKAKJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:09:26 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:46165 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946540AbWKAKJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:09:25 -0500
Message-ID: <45487246.2080309@sw.ru>
Date: Wed, 01 Nov 2006 13:09:10 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@openvz.org
Subject: 2.6.19-rc3-mm1: compilation fails if CONFIG_KEVENT is disabled
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Evgeniy,

Probably this issue is already known for you, but anyway:

[linux-2.6.19-rc3-mm1]$ ARCH=i386 make
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.rodata+0x520): In function `sys_call_table':
: undefined reference to `sys_kevent_get_events'
arch/i386/kernel/built-in.o(.rodata+0x524): In function `sys_call_table':
: undefined reference to `sys_kevent_ctl'
arch/i386/kernel/built-in.o(.rodata+0x528): In function `sys_call_table':
: undefined reference to `sys_kevent_wait'
make: *** [.tmp_vmlinux1] Error 1
[linux-2.6.19-rc3-mm1]$ grep KEVENT .config
CONFIG_GENERIC_CLOCKEVENTS=y
# CONFIG_KEVENT is not set

thank you,
	Vasily Averin
