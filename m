Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318037AbSHHWv1>; Thu, 8 Aug 2002 18:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318044AbSHHWv1>; Thu, 8 Aug 2002 18:51:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35828 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318037AbSHHWv1>; Thu, 8 Aug 2002 18:51:27 -0400
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
	mips, m68k, sh, cris to use it
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028846417.1669.95.camel@ldb>
References: <Pine.LNX.4.44.0208090018470.8911-100000@serv> 
	<1028846417.1669.95.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 01:11:11 +0100
Message-Id: <1028851871.28883.126.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 23:40, Luca Barbieri wrote:
> > The compiler can cache the value in a register
> It shouldn't since it is volatile and the machine has instructions with
> memory operands.

I'm curious what part of C99 guarantees that it must generate

	add 1 to memory

not

	load memory
	add 1
	store memory

It certainly guarantees not to cache it for use next statement, but does
it actually persuade the compiler to use direct operations on memory ?

I'm not a C99 language lawyer but genuinely curious

