Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284088AbRLOXJy>; Sat, 15 Dec 2001 18:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284117AbRLOXJo>; Sat, 15 Dec 2001 18:09:44 -0500
Received: from peace.netnation.com ([204.174.223.2]:27561 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S284088AbRLOXJm>; Sat, 15 Dec 2001 18:09:42 -0500
Date: Sat, 15 Dec 2001 15:09:40 -0800
From: Simon Kirby <sim@netnation.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
Message-ID: <20011215150940.A9612@netnation.com>
In-Reply-To: <Pine.LNX.4.33.0112141237470.3063-100000@penguin.transmeta.com> <200112151019.fBFAJgS235075@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200112151019.fBFAJgS235075@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sat, Dec 15, 2001 at 05:19:42AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 05:19:42AM -0500, Albert D. Cahalan wrote:

> > I do agree, I've used "kill -9 -1" myself.
> 
> This means: EVERYTHING DIE DIE DIE!!!!
> 
> On a Digital UNIX system, I do "/bin/kill -9 -1" often. I expect it to
> kill the shell. This is a nice way to quickly log out and wipe out any
> background processes that might try to save state or continue running.

Exactly.

And then init spawns your getty again, and you log in again, and you
continue doing what you were doing.

Or you could just let it not kill the process doing the killing, and
you'd be more productive.

My point is that I can't see a valid case where we _actually want_ -1 to
send to itself also.  Yes, I know the standards don't mention this.  They
also don't explicity disallow not sending to the originating process, so
I don't see what the big problem is.

Does anybody have a case where including itself is actually useful?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
