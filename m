Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316998AbSEWTzb>; Thu, 23 May 2002 15:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317004AbSEWTza>; Thu, 23 May 2002 15:55:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:782 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316998AbSEWTz2>; Thu, 23 May 2002 15:55:28 -0400
Date: Thu, 23 May 2002 12:54:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <3CED2F54.8000809@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0205231251430.2815-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 May 2002, Martin Dalecki wrote:
> 
> Hey and finally if someone want's to use /dev/port for
> developement on some slow control experimental hardware for example.
> Why doesn't he just delete the - signs at the front lines
> of the patch deleting it plus module register/unregister trivia and
> compile it as a *separate* character device module ?

That's not a productive approach, Martin.

Yes, with open source you can do whatever you want.

HOWEVER, there is a huge amount of advantage to having a common base that 
is big enough to matter: why do you think MS does well commercially? 

It's important to _not_ have to force people to do site-specific (or 
problem-specific) hacks, even if they could do so. Because having to have 
site-specific hacks detracts from the general usability of the code.

So when simplifying, it's not just important to say "we could do without 
this". You have to also say "and nobody can reasonably expect to need it".

Which doesn't seem to be the case with /dev/ports. So it stays.

		Linus

