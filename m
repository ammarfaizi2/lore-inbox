Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbTALUUp>; Sun, 12 Jan 2003 15:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbTALUUH>; Sun, 12 Jan 2003 15:20:07 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:29329 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S267503AbTALUS7>;
	Sun, 12 Jan 2003 15:18:59 -0500
Date: Sun, 12 Jan 2003 13:23:48 -0700
From: yodaiken@fsmlabs.com
To: Valdis.Kletnieks@vt.edu
Cc: robw@optonline.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112132348.A11893@hq.fsmlabs.com>
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com> <1042401596.1209.51.camel@RobsPC.RobertWilkens.com> <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Sun, Jan 12, 2003 at 03:18:38PM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 03:18:38PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 12 Jan 2003 14:59:57 EST, Rob Wilkens said:
> 
> > In general, if you can structure your code properly, you should never
> > need a goto, and if you don't need a goto you shouldn't use it.  It's
> > just "common sense" as I've always been taught.  Unless you're
> > intentionally trying to write code that's harder for others to read.
> 
> Now, it's provable you never *NEED* a goto.  On the other hand, *judicious*
> use of goto can prevent code that is so cluttered with stuff of the form:
> 
>         if(...) {
> 		...
> 		die_flag = 1;
> 		if (!die _flag) {...
> 		
> Pretty soon, you have die_1_flag, die_2_flag, die_3_flag and so on,
> rather than 3 or 4 "goto bail_now;".
> 
> The real problem is that C doesn't have a good multi-level "break" construct.

longjump. Used with good effect in the plan9 code.

Probably takes more coordination than is possible in Linux and has marginal
benefit, but it looks nice.






-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
www.fsmlabs.com  www.rtlinux.com
1+ 505 838 9109

