Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSANKuW>; Mon, 14 Jan 2002 05:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289189AbSANKuD>; Mon, 14 Jan 2002 05:50:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13581 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289188AbSANKtz>;
	Mon, 14 Jan 2002 05:49:55 -0500
Message-ID: <3C42B7CF.96032B4D@mandrakesoft.com>
Date: Mon, 14 Jan 2002 05:49:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: drivers missing __devexit_p in 2.4.18pre3
In-Reply-To: <20020114030734.GB17592@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> 
> A quick check of the source code shows that the following drivers
> appear to still be lacking the devinit fixes which are needed for
> the kernel to compile when using newer versions of binutils.
> 
> Each of these files probably needs the following (though I'm too
> lazy to do it all myself, since my kernel doesn't use any of this
> stuff):
> 
>         s/remove:\(.*\)/remove:__devexit_p(\1)/g
> 
> drivers/net/wan/dscc4.c
> drivers/net/tokenring/abyss.c
> drivers/net/tokenring/tmspci.c
> drivers/net/pcnet32.c
> drivers/net/sis900.c
> drivers/net/dmfe.c
> drivers/net/rcpci45.c
> drivers/net/hamachi.c
> drivers/net/wireless/orinoco_plx.c

I dunno if all of these qualify as hotplug drivers, needing __devfoo at
all?

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
