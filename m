Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291266AbSBGUOG>; Thu, 7 Feb 2002 15:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291267AbSBGUNu>; Thu, 7 Feb 2002 15:13:50 -0500
Received: from zero.tech9.net ([209.61.188.187]:25360 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291262AbSBGUMd>;
	Thu, 7 Feb 2002 15:12:33 -0500
Subject: Re: [RFC] New locking primitive for 2.5
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Dave Hansen <haveblue@us.ibm.com>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel@vger.kernel.org, mingo@elte.hu, nigel@nrg.org
In-Reply-To: <3C62DE3E.DE15CAF2@zip.com.au>
In-Reply-To: <3C629F91.2869CB1F@dlr.de>,		<3C629F91.2869CB1F@dlr.de>
	<1013107259.10430.29.camel@phantasy> <3C62D49A.4CBB6295@zip.com.au>
	<3C62DABA.3020906@us.ibm.com>  <3C62DE3E.DE15CAF2@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Feb 2002 15:11:46 -0500
Message-Id: <1013112717.10430.79.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-07 at 15:06, Andrew Morton wrote:

> A dynamic lock which says "we've spun for too long, let's sleep"
> seems to be a tradeoff between programmer effort and efficiency,
> and a bad one at that.

I'm not so sure.  What if we can't _know_ how long the lock will be held
because we don't know the status of the holder?  What if _he_ is
sleeping on some other lock or their are a lot of contending processes?

Certainly I agree, we need to put forth effort into designing things
right and with a minimal amount of lock held time.

> Possibly the locks could become more adaptive, and could, at
> each call site, "learn" the expected spintime.  But it all seems
> too baroque to me.

Agreed, this is much too much ;-)

	Robert Love

