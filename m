Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316620AbSEUV0d>; Tue, 21 May 2002 17:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316613AbSEUV0b>; Tue, 21 May 2002 17:26:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48644 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316620AbSEUV0Y>; Tue, 21 May 2002 17:26:24 -0400
Date: Tue, 21 May 2002 14:25:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <20020521211727.GG22878@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0205211423490.1405-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 May 2002, Pavel Machek wrote:
> 
> If you pass bad pointer to memcpy(), you don't expect any reasonable
> return value, right?

Actually, if I pass a bad pointer to memcpy(), and I have a handler for
the SIGSEGV that fixes up the thing, yes, by golly, I _do_ expect memcpy()  
to get the right value.

If it doesn't, then the system is BROKEN.

Face it Pavel, you're WRONG. You're so incredibly wrong that this is not 
worth even discussing. Linux does it right now, and I won't break that 
correct behaviour just because somebody has a incorrect and silly view of 
what is readable.

Face it, copy_to/from_user does the RIGHT THING, and stop whining about 
it.

		Linus

