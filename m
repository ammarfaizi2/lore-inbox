Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbTI1Mvc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 08:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbTI1Mvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 08:51:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56333 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262536AbTI1Mvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 08:51:31 -0400
Date: Sun, 28 Sep 2003 13:50:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bernardo Innocenti <bernie@develer.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928135046.A30736@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Bernardo Innocenti <bernie@develer.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309281213240.4929-100000@callisto>; from geert@linux-m68k.org on Sun, Sep 28, 2003 at 12:14:18PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 12:14:18PM +0200, Geert Uytterhoeven wrote:
> 
> On Sat, 27 Sep 2003, Linus Torvalds wrote:
> > Bernardo Innocenti:
> >   o GCC 3.3.x/3.4 compatiblity fix in include/linux/init.h
> 
> This change breaks 2.95 for some source files, because <linux/init.h> doesn't
> include <linux/compiler.h>. Do you want to have the missing include added to
> <linux/init.h>, or to the individual source files that need it?

It also breaks gcc 3.2.2 / gcc 3.3 as well:

arch/arm/mach-sa1100/leds.c:51: error: parse error before "__attribute_used__"
arch/arm/mach-pxa/leds.c:29: error: parse error before "__attribute_used__"

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
