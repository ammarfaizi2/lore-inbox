Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274803AbRJNIXU>; Sun, 14 Oct 2001 04:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274806AbRJNIXJ>; Sun, 14 Oct 2001 04:23:09 -0400
Received: from AMontpellier-201-1-5-223.abo.wanadoo.fr ([193.251.15.223]:3847
	"EHLO awak") by vger.kernel.org with ESMTP id <S274803AbRJNIWu> convert rfc822-to-8bit;
	Sun, 14 Oct 2001 04:22:50 -0400
Subject: Re: Security question: "Text file busy" overwriting executables but
	not shared libraries?
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1lmiera0x.fsf@frodo.biederman.org>
In-Reply-To: <Pine.LNX.4.33.0110131516350.8983-100000@penguin.transmeta.com>
	 <m1lmiera0x.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16.99+cvs.2001.10.11.16.13 (Preview Release)
Date: 14 Oct 2001 10:17:24 +0200
Message-Id: <1003047444.10966.50.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le dim 14-10-2001 à 08:49, Eric W. Biederman a écrit :
> Also read-with-PAGE_COPY has some really interesting implications for the
> page out routines.  Because anytime you start the page out you have to
> copy the page.  Not exactly when you want to increase the memory presure.
> And not at all suitable for shared libraries.

I didn't understood very well why you would want to swap out a page
marked PAGE_COPY ? Doesn't it make sense to special-case it and just
leave it "in the file", as long as it's untouched ?

	Xav

