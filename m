Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbTAJOTI>; Fri, 10 Jan 2003 09:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbTAJOTI>; Fri, 10 Jan 2003 09:19:08 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24210
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265095AbTAJOTH>; Fri, 10 Jan 2003 09:19:07 -0500
Subject: Re: [2.4.20] e1000 as module gives unresolved symbol _mmx_memcpy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042206299.1694.12.camel@paragon.slim>
References: <1042206299.1694.12.camel@paragon.slim>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042211643.31612.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 15:14:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 13:45, Jurgen Kramer wrote:
> Hi,
> 
> While trying to use the e1000 as a module with kernel 2.4.20 it gives
> me a unresolved symbol while trying to insmod the module. The offending
> symbol is _mmx_memcpy. When the driver is compiled into the kernel
> there's no problem.
> 
> I am running the kernel on a VIA Eden with 800MHz C3. Does this have
> something to do with the fact that kernels for the VIA C3 are now
> compiled with i486 optimisations (so maybe no MMX support?)?

Make sure you build from distclean if you've built for other cpu options
before. (cp .config ..; make distclean; cp ../.config .config; make oldconfig..

