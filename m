Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312499AbSCYS6h>; Mon, 25 Mar 2002 13:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312503AbSCYS6R>; Mon, 25 Mar 2002 13:58:17 -0500
Received: from mail-gw.sonicblue.com ([209.10.223.218]:29943 "EHLO
	mail-gw.sonicblue.com") by vger.kernel.org with ESMTP
	id <S312499AbSCYS6H>; Mon, 25 Mar 2002 13:58:07 -0500
Message-ID: <37D1208A1C9BD511855B00D0B772242C011C7F15@corpmail1.sc.sonicblue.com>
From: Peter Hartley <PDHartley@sonicblue.com>
To: linux-mips@oss.sgi.com, linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: RE: Does e2fsprogs-1.26 work on mips?
Date: Mon, 25 Mar 2002 11:00:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H J Lu wrote:
> What are you talking about? It doesn't matter which kernel header
> is used. glibc doesn't even use /usr/include/asm/resource.h nor
> should any user space applications.

It's not about /usr/include/asm/resource.h, it's about
/usr/include/asm/unistd.h, where the syscall numbers are defined.

This is presumably what the "#ifdef __NR_ugetrlimit" in
sysdeps/unix/sysv/linux/i386/getrlimit.c is meant to be testing against --
nothing in the glibc-2.2.5 distribution itself defines that symbol. Surely a
Linux glibc doesn't compile without the target system's linux/* and asm/*
headers?

2.4's /usr/include/asm/unistd.h defines __NR_ugetrlimit but 2.2's doesn't.

	Peter
