Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291272AbSBGUVo>; Thu, 7 Feb 2002 15:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291271AbSBGUVf>; Thu, 7 Feb 2002 15:21:35 -0500
Received: from zero.tech9.net ([209.61.188.187]:34320 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291267AbSBGUVX>;
	Thu, 7 Feb 2002 15:21:23 -0500
Subject: Re: [RFC] New locking primitive for 2.5
From: Robert Love <rml@tech9.net>
To: yodaiken@fsmlabs.com
Cc: Martin Wirth <Martin.Wirth@dlr.de>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au, torvalds@transmet.com, mingo@elte.hu, nigel@nrg.org
In-Reply-To: <20020207131550.A21935@hq.fsmlabs.com>
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <1013107259.10430.29.camel@phantasy>
	<20020207125853.B21354@hq.fsmlabs.com> <1013112523.9534.75.camel@phantasy> 
	<20020207131550.A21935@hq.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Feb 2002 15:20:24 -0500
Message-Id: <1013113285.11659.84.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-07 at 15:15, yodaiken@fsmlabs.com wrote:

> I'd love to hear how things could be done right here. 
> There seem to be 3 choices for reader writer locks

Assuming there is no

	4. a solution that works

(and I do not assume that) we can just not do inheritance under
reader-writer locks and that means they remain as spin locks.  Normal
spin locks remain proper candidates.

I never mentioned anything about reader-writer locks in my original
email.  Most of the long-held locks I am considering are not in this
category anyway ...

	Robert Love

P.S. If this is going to turn into another priority-inheritance flame, I
am stopping here.  Let's take it off-list or just drop it, please.  I'd
much prefer to discuss the current combilock issue which is at hand. ;)

