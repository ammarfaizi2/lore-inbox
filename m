Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278660AbRJXQ6R>; Wed, 24 Oct 2001 12:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278661AbRJXQ6H>; Wed, 24 Oct 2001 12:58:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39693 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278660AbRJXQ5x> convert rfc822-to-8bit; Wed, 24 Oct 2001 12:57:53 -0400
Date: Wed, 24 Oct 2001 09:55:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <1003942008.9892.100.camel@nomade>
Message-ID: <Pine.LNX.4.33.0110240953010.8278-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id JAA19540
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24 Oct 2001, Xavier Bestel wrote:
>
> le mer 24-10-2001 à 18:15, Linus Torvalds a écrit :
> > Also, realize that the act of suspension is STARTED BY THE USER. Which
>
> ... or triggered by some kind of inactivity timer, or low battery
> condition.

Note that even when that happens, it's not supposed to be the kernel start
_starts_ the activity of suspension.

An inactivity timer or low battery notification will just notify the
proper deamon, and the policy on what to do should be in user space.  For
example, on low battery you might want to set up a X window warning the
user that the machine _will_ suspend in five seconds. And the kernel
certainly won't do that.

So as far as the kernel is concerned, a suspend is _always_ started by
"the user". Of course, the whole point with computers is that many things
can be automated, and "the user" may not be a human sitting at the
machine.

		Linus

