Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316835AbSGHKNA>; Mon, 8 Jul 2002 06:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316837AbSGHKM7>; Mon, 8 Jul 2002 06:12:59 -0400
Received: from soleil.uvsq.fr ([193.51.24.1]:7440 "EHLO soleil.uvsq.fr")
	by vger.kernel.org with ESMTP id <S316835AbSGHKM6>;
	Mon, 8 Jul 2002 06:12:58 -0400
Date: Mon, 8 Jul 2002 12:15:35 +0200
From: Bruno Pujol <pujol@isty-info.uvsq.fr>
To: linux-kernel@vger.kernel.org
Subject: system call
Message-ID: <20020708121535.A6642@romuald.isty-info.uvsq.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Do someone know how to add a system call for the kernel 2.4.8 ?

I did know how to do it for an older version (2.0.35) :
- add a line in the file : /usr/src/linux/include/asm/unistd.h
	#define __NR_my_systemcall	XXXX (where XXXX is the number for my new system call)

- modify the file /usr/src/linux/arch/i386/kernel/entry.S
	- add my system call 
		.long SYMBOL_NAME (my_systemcall) at the end of the system callslist
	- modify le last line of the file :
		.space (NR_syscalls-166)*4   <= replace the 166 by 167


After this changes, I only needed to recompile the kernel and reboot with it... and a user's program could use the new system call...
But with my new kernel, this manupilation doesn't still work.

PUJOL Bruno
