Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268674AbUIAFuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268674AbUIAFuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 01:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUIAFuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 01:50:32 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:54234 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268657AbUIAFuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 01:50:23 -0400
Message-ID: <41356321.4030307@namesys.com>
Date: Tue, 31 Aug 2004 22:50:25 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com>
In-Reply-To: <41352279.7020307@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, you are looking at this like a lieutenant instead of an HQ 
staffer, which is unusual of you.

You are saying, 1-2% simpler and better, no biggie, why work so hard to 
get it?

And we are saying, 1-2% simpler and better, times thousands of 
applications, wow! That's a lot!

Yes, changing cat to use openat() is no big deal. 1-2% additional coding 
cost for cat, who cares? But if you add 1-2% coding cost to every 
application which might access an attribute/stream/whatever, well, that 
totals more than the effort of authoring emacs. Can you see that?

Namespace simplifications and empowerments are force multipliers. They 
don't add to Linux like writing a new app adds to Linux, they add to 
Linux like adding percentage improvements to every app in Linux adds to 
Linux. HQ staffer types know that if you collect enough itty bitty 
little force multipliers, you win the war. Whether the troops have to 
spend five minutes a day polishing their shoes because their type of 
shoe needs polishing, that matters more than losing a tank battalion, 
when you are a major power. Linux is a major power.

This is a software engineering issue. We are discussing improvements 
that because they are diffused throughout the OS in their impact, seem 
like no big deal. But they are a big deal. One of the major determinants 
of an organization's efficiency is whether the management can recognize 
widely diffused inefficiencies as well as it can recognize focused 
inefficiencies of the same magnitude.

David is so very right about the usability issues. Usability is all 
about trivia. Usability battles feature no dragons, they feature armies 
of spiders. If you add one step to what a user needs to do to get to the 
data with an app, that matters a lot. That's doubling the spider army. 
Making a 2 step process to access data into a one step process to access 
the data halves the time cost of accessing the data. Lifestyle 
efficiency is mostly about reducing the cost of trivia, because trivia 
is most of what we do. Most people have as much interest in reading the 
man page for tar as you have in learning how to turn the hand crank to 
start your car. Just the look of "tar -xf" turns them away. Crypto-Geek 
gobbledy-gook is what it is. Let's value their time, there are a lot of 
them.

Hans

David Masover wrote:

>
>
> It's not about the kernel, it's about the interface. And see my other 
> mail:
> cat foo.zip/README
> less foo.zip/contents/bar.c
> is a lot easier than
> lynx http://google.com/search?q=zip
> emerge zip
> man zip
> unzip foo.zip
> cat bar.c
> which already assumes quite a lot of expertise.
>
>
