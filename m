Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266051AbUALExv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 23:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUALExu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 23:53:50 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:41696 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S266051AbUALExs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 23:53:48 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Linus Torvalds <torvalds@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Date: Sun, 11 Jan 2004 23:53:43 -0500
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
References: <20040109014003.3d925e54.akpm@osdl.org> <3FFF79E5.5010401@winischhofer.net> <Pine.LNX.4.58.0401111502380.1825@evo.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401111502380.1825@evo.osdl.org>
Organization: Organization: None, detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401112353.43282.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.56.190] at Sun, 11 Jan 2004 22:53:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 January 2004 21:58, Linus Torvalds wrote:
>On Sat, 10 Jan 2004, Thomas Winischhofer wrote:
>> The whole framebuffer stuff in 2.6 is ancient. (Look at the file
>> dates.)
>
>Note that the fb stuff is ancient because it's basically not
> maintained as far as I'm concerned.
>
>I occasionally get huge drops from James, and they invariably break
> stuff. Which means that I often decide (espcially when trying to
> stabilize things) that I just can't _afford_ to apply the fr*gging
> patches. Because by past experience applying one of the big
> "everything changes" patches tends to break more things that it
> fixes.
>
>I'm sorry, but this i show it is.  The fbcon people have been
> changing interfaces faster than they have been fixing bugs in the
> code. Together with the fact that most of the development seems to
> happen in outside trees, and nobody ever sends me fixes relative to
> the released tree, this makes for a pretty bad situation.
>
>I really think that development should happen in the regular tree,
> or at least be synched up in reasonable chunks THAT DO NOT BREAK
> everything.
>
>I realize that some fb developers seem to disagree with me, but the
> fact is, the way things are done now, fb will _always_ be broken.
> Most people for whom the standard kernel works will never test the
> fb development trees, so those trees will never get any amount of
> reasonable testing. As a result, they WILL be buggy, and synching
> with them WILL be painful as hell.
>
>There is a d*mn good reason for why development should happen
>incrementally, and in the standard trees, and not in some outside
> tree. For one: testing. For another: figuring out when things break
> in a timely manner.
>
>		Linus
>-

I can well see your reticence in view of the situation, I think I'd be 
gun-shy too.  Its called prudence.

However, since I've been running 2.6.1-mm1 here, using the rivafb with 
an elderly gforce2-mx2 32 megger, I've noted that when running 
kde-3.1.1a with 8 windows, and a couple of them have multimegabyte 
backdrops, the biggest one being that famous deep space shot from 
hubble of about 4 or 5 months back.  In any other kernel, switching 
to that window took about 12 seconds for the backdrop to be converted 
to 1600x1200x32 and drawn the first time and about 8 seconds for the 
next time.  But with this 2.6.1-mm1 kernel, that repeat window switch 
is so close to instant that I cannot see it being drawn.

So as far as I'm concerned, this particular set of fb patches to 
rivafb *need* to stay in mainline.  I'd sure appreciate it, a bunch.

This ones a winner I think.
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

