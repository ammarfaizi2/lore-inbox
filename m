Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTIDXUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTIDXUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:20:45 -0400
Received: from ozlabs.org ([203.10.76.45]:31896 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261296AbTIDXTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:19:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16215.51281.872936.333230@nanango.paulus.ozlabs.org>
Date: Fri, 5 Sep 2003 09:18:41 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <Pine.GSO.4.21.0309041449260.8244-100000@waterleaf.sonytel.be>
References: <16215.13051.836875.270440@nanango.paulus.ozlabs.org>
	<Pine.GSO.4.21.0309041449260.8244-100000@waterleaf.sonytel.be>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven writes:

> inb() and friends are for ISA/PCI I/O space
> isa_readb() and friends are for ISA memory space
> readb() and friends are for PCI memory space (after ioremap())
> 
> That's why other buses (e.g. SBUS and Zorro) have their own versions of
> ioremap() and readb() etc.).

I suggest you fix Documentation/zorro.txt then: 8-)

: 		  Writing Device Drivers for Zorro Devices
: 		  ----------------------------------------
: 
: Written by Geert Uytterhoeven <geert@linux-m68k.org>
: Last revised: February 27, 2000

[snip]

:   - Zorro III address space must be mapped explicitly using ioremap() first
:     before it can be accessed:
:  
: 	  virt_addr = ioremap(bus_addr, size);
: 	  ...
: 	  iounmap(virt_addr);

Regards,
Paul.
