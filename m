Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262508AbTCZU5X>; Wed, 26 Mar 2003 15:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262510AbTCZU5X>; Wed, 26 Mar 2003 15:57:23 -0500
Received: from mail.zmailer.org ([62.240.94.4]:59554 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S262508AbTCZU5W>;
	Wed, 26 Mar 2003 15:57:22 -0500
Date: Wed, 26 Mar 2003 23:08:32 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       samel@mail.cz, ma@dt.e-technik.uni-dortmund.de
Subject: Re: BK-kernel-tools/shortlog update
Message-ID: <20030326210832.GC29167@mea-ext.zmailer.org>
References: <20030326103036.064147C8DD@merlin.emma.line.org> <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 09:21:22AM -0800, Linus Torvalds wrote:
...
> Btw, one feature I'd like to see in shortlog is the ability to use 
> regexps for email address matching, ie something like
> 
> 	'torvalds@.*transmeta.com' => 'Linus Torvalds'
> 	... 
> 	'alan@.*swansea.linux.org.uk' => 'Alan Cox'
> 	...
... 
> I don't know whether you can force perl to do something like this, but if 
> somebody were to try...

My perl-incantation wizard friend (I consider myself mere journeyman)
uses usually convoluted  'map'  constructs to do things like this.
It is amazing high-power way to make things -- and often helps you to
make "write only" script.

Wrapping converter regular expressions into map {} structure gives
something like:

   @summary = map {
	   s/torvalds\@.*transmeta.com/Linus Torvalds/,
	   s/alan\@.*swansea.linux.org.uk/Alan Cox/,
	   ... etc ...
	   1
	} @summary;

See "man perlfunc"  and look for " map ".

> 		Linus

/Matti Aarnio
