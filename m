Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbTAPDdW>; Wed, 15 Jan 2003 22:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbTAPDdW>; Wed, 15 Jan 2003 22:33:22 -0500
Received: from main.gmane.org ([80.91.224.249]:17380 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S266968AbTAPDdU>;
	Wed, 15 Jan 2003 22:33:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: any chance of 2.6.0-test*?
Date: Sun, 12 Jan 2003 14:46:07 -0600
Message-ID: <avsk45$vub$1@main.gmane.org>
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com> <1042401596.1209.51.camel@RobsPC.RobertWilkens.com> <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> On Sun, 12 Jan 2003 14:59:57 EST, Rob Wilkens said:
> 
>> In general, if you can structure your code properly, you should never
>> need a goto, and if you don't need a goto you shouldn't use it.  It's
>> just "common sense" as I've always been taught.  Unless you're
>> intentionally trying to write code that's harder for others to read.
> 
> Now, it's provable you never *NEED* a goto.  On the other hand,
> *judicious* use of goto can prevent code that is so cluttered with stuff
> of the form:
> 
>         if(...) {
> ...
> die_flag = 1;
> if (!die _flag) {...
> 
> Pretty soon, you have die_1_flag, die_2_flag, die_3_flag and so on,
> rather than 3 or 4 "goto bail_now;".
> 
> The real problem is that C doesn't have a good multi-level "break"
> construct. On the other hand, I don't know of any language that has a good
> one - some allow "break 3;" to break 3 levels- but that's still bad
> because you get screwed if somebody adds an 'if' clause....

perl has a pretty nice one... you can label each construct to which break is
applicable (ie, loop or whatever) then say "break foo" to escape that
struture (and any others you happen to be inside.

