Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318077AbSHHWYg>; Thu, 8 Aug 2002 18:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318078AbSHHWYg>; Thu, 8 Aug 2002 18:24:36 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:28167 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318077AbSHHWYg>; Thu, 8 Aug 2002 18:24:36 -0400
Date: Fri, 9 Aug 2002 00:27:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Luca Barbieri <ldb@ldb.ods.org>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
 mips, m68k, sh, cris to use it
In-Reply-To: <1028844681.1669.80.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208090018470.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9 Aug 2002, Luca Barbieri wrote:

> - Didn't implement atomic_{add,sub,inc,dec}_return. This is currently
> not used in the generic kernel but it can be useful.

m68k has a cmpxchg like instruction, which can be used for that.

> - Had inline assembly for things the compiler should be able to generate
> on its own

The compiler can cache the value in a register, the assembly forces that
into memory. __ARCH_ATOMIC_HAVE_MEMORY_OPERANDS won't work because of
that.

bye, Roman

