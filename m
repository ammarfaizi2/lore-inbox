Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSHARXd>; Thu, 1 Aug 2002 13:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHARXd>; Thu, 1 Aug 2002 13:23:33 -0400
Received: from www.transvirtual.com ([206.14.214.140]:44294 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315988AbSHARXd>; Thu, 1 Aug 2002 13:23:33 -0400
Date: Thu, 1 Aug 2002 10:26:48 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [PATCH] console part 2.
In-Reply-To: <20020801000003.A24516@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208011024390.12252-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A quick read through reveals:
>
> -		printk("mdacon: MDA card not detected.\n");
> +		printk("KERN_WARNING mdacon: MDA card not detected.\n");
>
> KERN_WARNING and friends should be outside the quotes.

Fixed.

> Secondly, the absolutely gigantic "switch (vc_state) {" stuff with
> extra layers of switch statements below it in decvte.c - I find this
> rather disgusting to read.  I bet the resulting asm is also disgusting.
> Isn't there a cleaner solution to this?  (I've been carrying around
> since 2.2 patches to the console layer to split this up mainly because
> some older versions of ARM gcc choked on it.  I'm not certain about
> current versions though.)

Yes it is disgusting. That is one of the reasons I placed it into a
seperate file. It is the same code as before. Could you send me that
patch. I'm interested in it :-)

> Also, something that should probably be fixed one day, but I wouldn't
> call it a show stopper:
>
> -#define SIZE(x) (sizeof(x)/sizeof((x)[0]))
> +#define SIZE(x)	(sizeof(x)/sizeof((x)[0]))
>
> We have ARRAY_SIZE(x) in linux/kernel.h which does this already.

Done.

