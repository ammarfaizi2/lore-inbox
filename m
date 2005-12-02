Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVLBOmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVLBOmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 09:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVLBOmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 09:42:10 -0500
Received: from mxsf15.cluster1.charter.net ([209.225.28.215]:59280 "EHLO
	mxsf15.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750750AbVLBOmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 09:42:09 -0500
X-IronPort-AV: i="3.99,206,1131339600"; 
   d="scan'208"; a="1864441299:sNHT17134104"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17296.23870.830876.450308@smtp.charter.net>
Date: Fri, 2 Dec 2005 09:42:06 -0500
From: "John Stoffel" <john@stoffel.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: tglx@linutronix.de, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       rmk+lkml@arm.linux.org.uk, ray-gmail@madrabbit.org,
       zippel@linux-m68k.org, linux-kernel@vger.kernel.org, george@mvista.com,
       johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <537CE371-F9A9-4255-A3B0-9DBDAD82591B@mac.com>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
	<Pine.LNX.4.61.0512010118200.1609@scrub.home>
	<23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
	<Pine.LNX.4.61.0512011352590.1609@scrub.home>
	<2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
	<20051201165144.GC31551@flint.arm.linux.org.uk>
	<20051201122455.4546d1da.akpm@osdl.org>
	<20051201211933.GA25142@elte.hu>
	<20051201135139.3d1c10df.akpm@osdl.org>
	<7D53372C-E138-4336-883F-A674BBBB09AA@mac.com>
	<20051201221553.GA19135@infradead.org>
	<1133481739.10478.54.camel@tglx.tec.linutronix.de>
	<537CE371-F9A9-4255-A3B0-9DBDAD82591B@mac.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kyle" == Kyle Moffett <mrmacman_g4@mac.com> writes:

Kyle> On Dec 01, 2005, at 19:02, Thomas Gleixner wrote:
>> On Thu, 2005-12-01 at 22:15 +0000, Christoph Hellwig wrote:
>>> Heh, in my dumb non-native speaker mind I'd expectit the other way  
>>> around, as in a timeout is expected to time out :)  and a timer is  
>>> expect to happen, as in say the timer the tells you your breakfast  
>>> egg is ready.
>> 
>> Which is perfectly the point Kyle made.

Kyle> In any case, the real important note here is that the two are
Kyle> pretty different concepts, ones that lend themselves to _very_
Kyle> different optimizations, that are currently lumped together.
Kyle> The very fact that some developers easily get them confused says
Kyle> that we need a good clean implementation of both distinct APIs
Kyle> with comparable documentation, including a bunch of good example
Kyle> usages.

I think the problem is in using the work 'time' in both.  Split that
so that they are seperate, and alot of the confusion will go away.  Do
I have a usefull suggestion?  No, I'm being fairly dumb this
morning... but just seeing all your smart guys getting confused makes
me think they rest of us would be lost too.

Hmm... how about:

	timer - gotta let me know exactly when it expires, I won't
		touch it until it does.

	reminder - I'll generally clean this up before it fires ,
		   don't care if I get reminded a bit later.

John
