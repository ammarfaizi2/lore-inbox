Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317864AbSHLLOk>; Mon, 12 Aug 2002 07:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSHLLOk>; Mon, 12 Aug 2002 07:14:40 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:26363 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317864AbSHLLOk>; Mon, 12 Aug 2002 07:14:40 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1028850350.28882.121.camel@irongate.swansea.linux.org.uk> 
References: <1028850350.28882.121.camel@irongate.swansea.linux.org.uk>  <Pine.LNX.4.44.0208082357170.8911-100000@serv> <1028844681.1669.80.camel@ldb> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Luca Barbieri <ldb@ldb.ods.org>, Roman Zippel <zippel@linux-m68k.org>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc, mips, m68k, sh, cris to use it 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Aug 2002 12:16:48 +0100
Message-ID: <20995.1029151008@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Possibly not - volatile doesnt guarantee the compiler won't do
> 	x = 1
> 	add *p into x
> 	store x into *p

Er, AIUI 'volatile' guarantees that '*p++' will do precisely that. It's a 
load, an add and a store, and the rules about volatile mean that the load 
and the store _must_ be separate.

--
dwmw2


