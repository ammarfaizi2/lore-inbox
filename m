Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVCUITX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVCUITX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 03:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVCUITX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 03:19:23 -0500
Received: from mail.suse.de ([195.135.220.2]:60138 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261671AbVCUITS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 03:19:18 -0500
Message-ID: <423E79DF.3030603@suse.de>
Date: Mon, 21 Mar 2005 08:38:07 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
Cc: Russell Miller <rmiller@duskglow.com>, erik.andren@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: Suspend-to-disk woes
References: <423B01A3.8090501@gmail.com>	 <20050319132612.GA1504@openzaurus.ucw.cz>	 <200503191220.35207.rmiller@duskglow.com>	 <20050319212922.GA1835@elf.ucw.cz> <1111364066.9720.2.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1111364066.9720.2.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
>
> On Sun, 2005-03-20 at 08:29, Pavel Machek wrote:

>> boot with "noresume", then mkswap.
>
> Yuck! Why panic when you know what is needed? A better solution is to

Ok, so let's

    printk("You booted another kernel than you suspended with.\n");
    printk("You have two options now:\n");
    printk(" - boot the kernel you suspended with\n");
    printk(" - pass 'noresume' at boot and mkswap your swap partition "
           " later\n");
    printk("Try again, player 1!\n");
    panic();

> tell the user they've messed up and give them the option to (1) reboot
> and try another kernel or (2) have swsusp restore the original swap
> signature and continue booting. This is what suspend2 does (with a
> timeout for the prompt). It's not that hard.

yes, but you need user input etc. Not considered a good idea IIRC.

Anyway, the hard thing to do is to find out when to bail out and when
not. The part that handles the user interface is the easier one :-)

Regards,

    Stefan

