Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135497AbRDZRAh>; Thu, 26 Apr 2001 13:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135685AbRDZRA1>; Thu, 26 Apr 2001 13:00:27 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:15039 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S135497AbRDZRAR>; Thu, 26 Apr 2001 13:00:17 -0400
Message-Id: <200104261700.MAA13391@asooo.flowerfire.com>
Date: Thu, 26 Apr 2001 10:00:02 -0700
From: Ken Brownfield <brownfld@irridia.com>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Subject: Re: [PATCH] Single user linux
Cc: <linux-kernel@vger.kernel.org>
To: <imel96@trustix.co.id>
X-Mailer: Apple Mail (2.387)
In-Reply-To: <Pine.LNX.4.33.0104262026140.1816-100000@tessy.trustix.co.id>
Mime-Version: 1.0 (Apple Message framework v387)
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday, April 26, 2001, at 07:03 AM, <imel96@trustix.co.id> wrote:
> he owns the computer, he may do anything he wants.

This sentence really stood out for me, and implies a profound lack of 
understanding of multi-user machines.  No offense intended.

I've been a Unix admin for over ten years, and I like to think that I 
know my way around pretty well.  But I do not and will NEVER log in to a 
machine as root to do work.  I am the only user of my MacOS X laptop and 
home Linux boxes, and I still have my own personal login on all of 
them.  What's at issue is not ownership or trust, but one of 
accountability and safety.

Any OS worth its weight in silicon will make a distinction between 
blessed and unblessed users.  It can be phrased in different ways -- 
root vs. non-root, admin vs. non-admin.  But no one should EVER log in 
to a machine as root.  Period. (1)

Multi-user/modern operating systems exist precisely to destroy the fatal 
flaw that you are attempting to reintroduce.  Users should have reduced 
privileges during normal use, and conditional privilege on demand.  Safe 
from User Error and no less functional on GUI-based systems.

People keep saying this, but I'll say it again.  This can easily be done 
in user-space.  This HAS been done.  Many times.  Well.  It's possible 
to put a user in privileged mode automatically, but I'm not convinced 
that an extra prompt to go into privileged mode is a bad thing from a 
usability standpoint.

So it doesn't need to be in the kernel.  And why put it there if it 
doesn't need to be?  Even if it's off by default, it's bloat.  And 
dangerous, conceptually flawed bloat that can't be disabled with 
'chkconfig' or 'rpm -e'.  And how many people will use it?  And should 
the kernel group allow them to from an out-of-box kernel?  As I 
understand it, part of the responsibility of the maintainers is to 
maintain a conceptually focused kernel.  There's nothing preventing you 
from distributing your patch, but inserting this into "the" kernel seems 
unacceptable IMVHO.

I think we understand the "why" of your patch, but I think you need to 
elucidate further on how the ends justify the means.

Sorry to kick a dead horse,
--
Ken.
brownfld@irridia.com

(1) Except for gnarly testbed/admin machines, etc. etc.
