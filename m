Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261777AbTCLVC7>; Wed, 12 Mar 2003 16:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbTCLVC7>; Wed, 12 Mar 2003 16:02:59 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:43276 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261777AbTCLVC4>; Wed, 12 Mar 2003 16:02:56 -0500
Message-Id: <200303122113.h2CLDSfR032057@pincoya.inf.utfsm.cl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-Reply-To: Message from Szakacsits Szabolcs <szaka@sienet.hu> 
   of "Wed, 12 Mar 2003 19:25:01 +0100." <Pine.LNX.4.30.0303121833530.18833-100000@divine.city.tvnet.hu> 
Date: Wed, 12 Mar 2003 17:13:28 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szakacsits Szabolcs <szaka@sienet.hu> said:

[...]

> The Code part of the Oops shows what's after EIP (i386). It's also
> important (if not more) what's before. I fail to see the difficulties
> to add this feature (or was it dropped?), ksymoops should handle it.

It is _hard_ to do with variable length instructions (CISC, remember?), the
code is designed to be easily decoded forward, noone executes code going
backwards. Finding out what starts at EIP is easy.

When I needed to look at the code in an Oops I'd either objdump(1)ed it or
compiled the offending stuff to assembler (possibly with custom CFLAGS to
get info on line numbers and such in the output).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
