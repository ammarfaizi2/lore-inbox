Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274831AbRIUU6J>; Fri, 21 Sep 2001 16:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274832AbRIUU6B>; Fri, 21 Sep 2001 16:58:01 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:46528 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S274831AbRIUU5s>;
	Fri, 21 Sep 2001 16:57:48 -0400
Message-Id: <m15kXN7-000QLZC@amadeus.home.nl>
Date: Fri, 21 Sep 2001 21:58:05 +0100 (BST)
From: arjan@fenrus.demon.nl
To: raybry@timesn.com (Ray Bryant)
Subject: Re: AIC-7XXX driver problems with 2.4.9 and L440GX+
cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BABA9F4.3677E423@timesn.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BABA9F4.3677E423@timesn.com> you wrote:
> [-- text/plain, encoding 7bit, 46 lines --]

> The AIC-7XXX version 6.2.1 driver hangs at startup under 2.4.x  (we've
> tried
> 2.4.2-2 (RH 7.1), 2.4.5, and 2.4.9).
> The complete boot output is attached; the interesting parts are 
> as follows:

You can try the updated BOOT disk Red Hat has made available for this, we
managed to workaround the bios bug for at least several motherboards.

But the 440GX chipset isn't really supported by linux; it contains some
Intel chips that nobody has the specification for and all 440GX bioses I've
seen have a buggy IRQ table as well, so that can't be used either. This
results in kernels not being able to get proper IRQ routing figured out. 2.2
gets it mostly right because it trusts a different bios table... which
breaks in other situations (don't put a cardbus controller in the machine,
2.2 will break). 

Greetings,
   Arjan van de Ven.
