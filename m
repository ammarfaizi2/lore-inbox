Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVCULVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVCULVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 06:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVCULVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 06:21:17 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:5779 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261668AbVCULVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 06:21:11 -0500
Subject: Re: Suspend-to-disk woes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Stefan Seyfried <seife@suse.de>
Cc: Russell Miller <rmiller@duskglow.com>, erik.andren@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <423E79DF.3030603@suse.de>
References: <423B01A3.8090501@gmail.com>
	 <20050319132612.GA1504@openzaurus.ucw.cz>
	 <200503191220.35207.rmiller@duskglow.com>
	 <20050319212922.GA1835@elf.ucw.cz>
	 <1111364066.9720.2.camel@desktop.cunningham.myip.net.au>
	 <423E79DF.3030603@suse.de>
Content-Type: text/plain
Message-Id: <1111404185.14853.2.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 21 Mar 2005 22:23:05 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-03-21 at 18:38, Stefan Seyfried wrote:
> Nigel Cunningham wrote:
> > Hi.
> >
> > On Sun, 2005-03-20 at 08:29, Pavel Machek wrote:
> 
> >> boot with "noresume", then mkswap.
> >
> > Yuck! Why panic when you know what is needed? A better solution is to
> 
> Ok, so let's
> 
>     printk("You booted another kernel than you suspended with.\n");
>     printk("You have two options now:\n");
>     printk(" - boot the kernel you suspended with\n");
>     printk(" - pass 'noresume' at boot and mkswap your swap partition "
>            " later\n");
>     printk("Try again, player 1!\n");
>     panic();

Still in the yuck category, although the better information is
definitely an improvement :>

> > tell the user they've messed up and give them the option to (1) reboot
> > and try another kernel or (2) have swsusp restore the original swap
> > signature and continue booting. This is what suspend2 does (with a
> > timeout for the prompt). It's not that hard.
> 
> yes, but you need user input etc. Not considered a good idea IIRC.

I understood that having it hang indefinitely was considered a bad idea.
Suspend2 already has code that does what I'm suggesting, and
incorporates a 30 second timeout.

> Anyway, the hard thing to do is to find out when to bail out and when
> not. The part that handles the user interface is the easier one :-)

Agreed. That's where Pavel's code might need a little hacking around.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

