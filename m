Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132312AbRCZDRX>; Sun, 25 Mar 2001 22:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132313AbRCZDRN>; Sun, 25 Mar 2001 22:17:13 -0500
Received: from c90610-a.alton1.il.home.com ([24.11.42.157]:19462 "EHLO
	www.linuxnet") by vger.kernel.org with ESMTP id <S132312AbRCZDQz>;
	Sun, 25 Mar 2001 22:16:55 -0500
Message-ID: <45961.192.168.1.5.985572801.squirrel@matthew.mattshouse.com>
Date: Sun, 25 Mar 2001 21:13:20 -0500 (EST)
Subject: Re: [PATCH] OOM handling
From: "Matthew Chappee" <matthew@mattshouse.com>
To: dalecki@evision-ventures.com
In-Reply-To: <3ABDF8A6.7580BD7D@evision-ventures.com>
In-Reply-To: <3ABDF8A6.7580BD7D@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Reply-To: matthew@mattshouse.com
X-Mailer: SquirrelMail (version 1.0.3)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK I just did it. as I already told I have "stress tested it" by 

> Since I'm one day late up to my promise to provide this
> patch it's actually fascinating that already 4 people (in esp. not
> newbees requesting a new /proc entry for everything)
> for reassurance that I will indeed implement it... Well 
> this kind of "high" and "eager" feadback seems for me to indicate  that
> there is very serious desire for it. And then of course I
> just have to ask our people working with DB's here at work as well :-).


I'm one of the four that contacted you. :-)  I'm certainly not a newbie and it appears that you nailed the reason that I'm interested.  I'm an Oracle DBA that runs a fairly large database(s) on Linux.  A patch like this is important.  Case in point:

We do not have loads of money, so we have to double up our servers.  A database server can also be an app server, or a web server, etc.  Now, let's say that Joe Surfer has 10 netscape sessions open on my database server (hey, talk to my boss, it's not my fault). He's grabbing Pr0n/MP3s/whatever as fast as our 'T' will allow.  One of the websites that he visits has some nasty java that bloats his browser to the point of OOM.  Something has to die in order for the machine to stay alive.  Remember the 100 sided die from D&D?  Roll it and kill -9?  Hopefully not, I should be able to tell the OOM_Killer to wipe out this user's stuff first, based on the prowess of his UID.

The point being, my database shouldn't be selected for termination.  Nobody ever got fired for kill -9'ing netscape, but Oracle is a different story.  I urge you, consider the patch.

> Ah... and of course I think this patch can already go directly 
> into the official kernel. The quality of code should permit 
> it. I would esp. request Rik van Riel to have a closer look
> at it...

Whoa, easy there trigger.  I'd rather have a wacked out OOM_Killer than a barely-tested alternative.

Matthew


