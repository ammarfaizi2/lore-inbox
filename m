Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263437AbRF1TAG>; Thu, 28 Jun 2001 15:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbRF1S74>; Thu, 28 Jun 2001 14:59:56 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:4996 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262685AbRF1S7n>;
	Thu, 28 Jun 2001 14:59:43 -0400
Message-ID: <3B3B7EC4.F4C8F2F0@mandrakesoft.com>
Date: Thu, 28 Jun 2001 15:00:20 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Dreker <patrick@dreker.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <Pine.LNX.4.33.0106280956030.15199-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Things like version strings etc sound useful, but the fact is that the
> only _real_ problem it has ever solved for anybody is when somebody thinks
> they install a new kernel, and forgets to run "lilo" or something. But
> even that information you really get from a simple "uname -a".
> 
> Do we care that when you boot kernel-2.4.5 you get "net-3"? No. Do we care
> that we have quota version "dquot_6.4.0"? No. Do we want to get the
> version printed for every single driver we load? No.
> 
> If people care about version printing, it (a) only makes sense for modules
> and (b) should therefore maybe be done by the module loader. And modules
> already have the MODULE_DESCRIPTION() thing, so they should NOT printk it
> on their own.  modprobe can do it if it wants to.

As Alan said, driver versions are incredibly useful.  People use update
their drivers over top of kernel drivers all the time.  Vendors do it
too.  "Run dmesg and e-mail me the output" is 1000 times more simple for
end users.


> So let's simply disallow versions, author information, and "good status"
> messages, ok? For stuff that is useful for debugging (but that the driver
> doesn't _know_ is needed), use KERN_DEBUG, so that it doesn't actually end
> up printed on the screen normally.

Note that KERN_DEBUG appears in dmesg by default in 2.4, AFAICS.  This
may be a big source of complaints, right there...

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
