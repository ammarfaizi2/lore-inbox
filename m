Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbSBISGn>; Sat, 9 Feb 2002 13:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSBISFo>; Sat, 9 Feb 2002 13:05:44 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:14349 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S283003AbSBISF2>;
	Sat, 9 Feb 2002 13:05:28 -0500
Date: Fri, 8 Feb 2002 23:10:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz,
        andre@linuxdiskcert.org
Subject: Re: ide cleanup
Message-ID: <20020208221016.GB988@elf.ucw.cz>
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz> <3C63C5EF.4050403@evision-ventures.com> <20020208133755.A10250@suse.cz> <3C63CF54.9090308@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C63CF54.9090308@evision-ventures.com>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>IDE is
> >>>* infested with polish notation
> >>>
> >>I don't see any polish notation there. Could you please explain what you 
> >>mean with this note?
> >>
> >
> >I think Pavel meant what I think is called "hungarian notation", adding
> >_t's to type identifiers or adding _i or i_ to integer variables.
> >
> The encoding of type signatures in function names is indeed called 
> hungarian notation.
> The _t at the end of type names is a POSIX habit of markup for system 
> defined types - this should *NOT*
> be used in user land programms but is OK for the kernel. However for the 
> ide drivers it's indeed unnecessary
> code noise.
> 
> Polish notation is the anglo-saxon term for a mathematical expression 
> syntax which is avoiding
> parents by not using an "in between" operator notation but using 
> functional notation instead.
> It was invented by ?ukasiewich at the beginning of the last century for 
> formal logic and is indeed more
> convenient there if you start to deal with long expressions.... Just to 
> clarify the terms OK?

Sorry, I really meant that nasty _t. (The driver even did things like 

struct foo xyzzy;
memset(&xyzzy, 0, sizeof(foo_t));

using both 'struct foo' and foo_t for one variable.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
