Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSETEtz>; Mon, 20 May 2002 00:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315780AbSETEtz>; Mon, 20 May 2002 00:49:55 -0400
Received: from [202.135.142.196] ([202.135.142.196]:18183 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315758AbSETEty>; Mon, 20 May 2002 00:49:54 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Sun, 19 May 2002 19:54:32 MST."
             <Pine.LNX.4.44.0205191951460.22433-100000@home.transmeta.com> 
Date: Mon, 20 May 2002 14:53:18 +1000
Message-Id: <E179fAd-0005vs-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0205191951460.22433-100000@home.transmeta.com> you wr
ite:
> 	ret = copy_from_user(xxx);
> 	if (ret)
> 		return ret;
> 
> which is apparently your suggestion.

Not quite:
	copy_from_user(xxx);

Is my suggestion.  No error return.

> So a lot of people didn't get it? Arnaldo seems to have fixed a lot of
> them already

Yeah, thanks to my kernel audit.  But I won't be auditing all 5,500
every release (I promised Alan I'd do 2.4 though: I'm waiting for the
next Marcelo kernel).

> and maybe you who apparently care can add _documentation_,
> but the fact is that there is no reason to make a less powerful interface.

It's been documented in the kernel docs.  It's also in the device
driver book.  And people still get it wrong because it's "special".

Please please please, Linus: to me this is like the min & max macros:
you didn't want a programmer trap in there, but everyone else
disagreed.  If there's any sane way we can get rid of this trap (which
has shown to cause real bugs), I would weigh it very carefully.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
