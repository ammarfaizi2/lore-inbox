Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267053AbRGMXBj>; Fri, 13 Jul 2001 19:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267060AbRGMXB2>; Fri, 13 Jul 2001 19:01:28 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:16133 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S267053AbRGMXBR>; Fri, 13 Jul 2001 19:01:17 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200107132207.AAA04762@kufel.dom>
Subject: Re: Makefile problem and modules
To: kufel!crm.mot.com!varagnat@green.mif.pg.gda.pl (Emmanuel Varagnat)
Date: Sat, 14 Jul 2001 00:07:04 +0200 (CEST)
Cc: kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl (linux-kernel@vger.kernel.org)
In-Reply-To: <3B4DBB46.24EB460F@crm.mot.com> from "Emmanuel Varagnat" at lip 12, 2001 04:59:18 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wrote a module for IPv6 but there is a case when it is
> compiled.
> (For the moment my code can only work as a module...)
> When IPv6 is compiled as a module, my module is well compiled.
> But if IPv6 is directly in the kernel, my module is not take
> into account (I've got no object file).
> 
> Here is the only line I added to the Makefile (near the end):
> 
> obj-$(CONFIG_IPV6_MYSTUFF)  += mystuff.o

In which directory? net/ipv6/ ?

Maybe you need to add

subdir-m += ipv6

in net/Makefile then.
net/ipv6 is not processed during module compilation when CONFIG_IPV6=y
(except net/ipv6/netfilter).

Andrzej
