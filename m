Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267682AbTAMAjQ>; Sun, 12 Jan 2003 19:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267689AbTAMAjQ>; Sun, 12 Jan 2003 19:39:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:53696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267682AbTAMAjP>;
	Sun, 12 Jan 2003 19:39:15 -0500
From: Randy Dunlap <rddunlap@osdl.org>
Message-ID: <1818.4.64.197.173.1042418884.squirrel@www.osdl.org>
Date: Sun, 12 Jan 2003 16:48:04 -0800 (PST)
Subject: Re: any chance of 2.6.0-test*?
To: <Valdis.Kletnieks@vt.edu>
In-Reply-To: <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com>
        <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
        <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
X-Priority: 3
Importance: Normal
Cc: <robw@optonline.net>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 12 Jan 2003 14:59:57 EST, Rob Wilkens said:
>
>> In general, if you can structure your code properly, you should never need
>> a goto, and if you don't need a goto you shouldn't use it.  It's just
>> "common sense" as I've always been taught.  Unless you're
>> intentionally trying to write code that's harder for others to read.
>
> Now, it's provable you never *NEED* a goto.  On the other hand, *judicious*
> use of goto can prevent code that is so cluttered with stuff of the form:
>
>         if(...) {
> 		...
> 		die_flag = 1;
> 		if (!die _flag) {...
>
> Pretty soon, you have die_1_flag, die_2_flag, die_3_flag and so on, rather
> than 3 or 4 "goto bail_now;".

Right.

> The real problem is that C doesn't have a good multi-level "break"
> construct. On the other hand, I don't know of any language that has a good
> one - some allow "break 3;" to break 3 levels- but that's still bad because
> you get screwed if somebody adds an 'if' clause....


The one that I used in a previous life was like so.  No "while"
or "for" constructs, only "do thisloop forever" with conditionals
all being explicitly coded inside the loop(s).  All based on:
  do [loopname] [forever];
    {block};
  end [loopname];

with {block} possibly containing "undo [loopname]".
An unnamed undo just terminates the innermost loop.
Named undo's can be used to terminate any loop level.

~Randy



