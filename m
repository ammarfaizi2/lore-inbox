Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSLQR0E>; Tue, 17 Dec 2002 12:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbSLQR0E>; Tue, 17 Dec 2002 12:26:04 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5347 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265457AbSLQR0D>;
	Tue, 17 Dec 2002 12:26:03 -0500
Date: Tue, 17 Dec 2002 09:33:46 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] : More module parameter compatibility for 2.5.52
Message-ID: <20021217173346.GA22924@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021217012646.GA18021@bougret.hpl.hp.com> <20021217043218.48D082C298@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021217043218.48D082C298@lists.samba.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 03:20:10PM +1100, Rusty Russell wrote:
> In message <20021217012646.GA18021@bougret.hpl.hp.com> you write:
> > 	Hi,
> > 
> > 	I've just downloaded 2.5.52 to try the new module parameter
> > support. Unfortunately, the letter 'c' was not implemented, and I need
> > it. This is used in few drivers (such as hp100, wavelan, wlan_cs...).
> 
> Cool, an undocumented type!  And they have explit sizes, and they're
> used in arrays.  Just wonderful.

	I can only say that they are more efficient than 's'...

> I prefer the fix below.  Does it work for you?
> 
> Rusty.

	With all due respect, your fix is quite ugly.
	And think about it this way : your new param architecture is
supposed to be flexible and supposed to allow modules to get
parameters in any shape or form. But, on the other hand, it's
impossible to implement something as simple as 'c' without ugly hacks.
	Maybe we can deduct from this that the new param API is not
flexible enough and that the simple addition of an opaque type (priv)
can have some value. From personal experience, most APIs that didn't
had mechanism to pass private data between an entity and the entity
handlers ended up regretting it and having to add it back at some
point.

	Have fun...

	Jean
