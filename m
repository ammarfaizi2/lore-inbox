Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVDEPsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVDEPsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVDEPrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:47:47 -0400
Received: from mail.portrix.net ([212.202.157.208]:25508 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261793AbVDEPqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:46:17 -0400
Message-ID: <4252B2B6.9020302@portrix.net>
Date: Tue, 05 Apr 2005 17:45:58 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: 2.6.12-rc2-mm1
References: <20050405000524.592fc125.akpm@osdl.org>
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bk-kbuild.patch

Something has broken make O= :

$ make mrproper
$ mkdir /tmp/42
$ make ARCH=alpha CROSS_COMPILE=alpha-linux- O=/tmp/42 defconfig
$ make ARCH=alpha CROSS_COMPILE=alpha-linux- O=/tmp/42
  Using /home/jdittmer/src/lk/linus as source for kernel
  GEN    /tmp/42/Makefile
  CHK     include/linux/version.h
  SYMLINK /tmp/42/include/asm -> include/asm-alpha
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
make[1]: *** No rule to make target `include/asm', needed by `arch/alpha/kernel/asm-offsets.s'.  Stop.
make: *** [_all] Error 2

Happens for most archs. See http://l4x.org/k/

Jan
