Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVCDJkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVCDJkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVCDJh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:37:58 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:62890
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262571AbVCDJhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:37:22 -0500
Subject: Re: RFD: Kernel release numbering
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304005450.05a2bd0c.akpm@osdl.org>
References: <20050302205826.523b9144.davem@davemloft.net>
	 <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com>
	 <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
	 <20050303151752.00527ae7.akpm@osdl.org>
	 <20050303234523.GS8880@opteron.random>
	 <20050303160330.5db86db7.akpm@osdl.org>
	 <20050304025746.GD26085@tolot.miese-zwerge.org>
	 <20050303213005.59a30ae6.akpm@osdl.org>
	 <1109924470.4032.105.camel@tglx.tec.linutronix.de>
	 <20050304005450.05a2bd0c.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 10:37:18 +0100
Message-Id: <1109929038.4032.146.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 00:54 -0800, Andrew Morton wrote:
> > I don't see that the releases are stable. They are defined stable by
> > proclamation. 
> 
> If they were stable we'd release the darn things!  

You are hitting the point. We release the darn things. 2.6.11 is
released and it is not stable enough, because it had not enough test
coverage.

> *obviously* -rc kernels are expected to still have problems.
>
> -rc just means "please start testing", not "deploy me on your corporate
> database server".

Yes this should be the meaning of -rc. But in reality it is not. And
thats the damned reason why people are ignoring -rc releases.

> People are smart enough to know that -rc3 will be less buggy than -rc1.

And they are smart enough to know that -rc3 is a complete different
beast as -rc1 and not a stabilized version of -rc1.

> > This 2.6.x.y tree will change nothing as long as the underlying problem
> > is not solved.
> 
> What underlying problem?  The fact that -rc1 comes a bit too early?  Spare
> me, that's just a nothing.  Anyone who is testing -rc kernels knows the
> score.

We are talking about how to convince more people to test -rc kernels in
order to have a stable release version. Those who are testing current -
rc kernels are not enough people to give this a good coverage.

> That being said, yes, I agree that we should use 2.4-style -pre and -rc. 
> But changing the names of things won't change anything.

Ack. Changing only the names is nonsense. You have to change the way it
works. Jeff pointed out correctly that this is also a human
communication problem. We have managed to scare people off testing -rc
kernels. So we end up with a release 2.6.X where people actually start
testing and complaining. Now we want to maintain a 2.6.X.Y tree which
fixes those problems. Thats plain wrong IMNSHO, because it moves out the
-rc phase to a 2.6.X.Y tree without real target. Linus called it sneaky
and thats what it is. A sneaky gimmick. People will debunk this.

We have different goals to achieve:

- Stable kernel releases
- Broad testing coverage of -rc versions
- Ongoing stable development
- Bleeding edge development

This is nothing new. Thats a _normal_ workflow in projects whether OSS
or commercial.

-mm             -Linus          -release
 |                |
 |--------------->|
 |                |
 |                pre1
 |                |
 |                pre..
 |                |
 |                preX ---------->rc1
 |                |                |
 |--------------->|               rc..
 |                |                |
 |                pre1            rcX = stable release
 |                |                |
 |                |               stable + security fixes
 |                pre..
 |                |
 |                preX ---------->rc1
 |                |                |
 |--------------->|               rc..
 |                |                |
 |                pre1            rcX = stable release
 |                |                |
 |                |               stable + security fixes
 |                pre..
 	
This is a clear seperation and solves several problems

- Linus must not do the boring real -rc steps
- -rc versions are likely to get good testing coverage
- Release versions will be stable
- Development is continous
- Release cycles will be more frequently

> > A clearly defined switch from -preX to -rc will give the avarage user a
> > clear sign where he might jump in and test. 
> 
> The average user has learnt "rc1 == pre1".  I don't expect that it matters
> much at all.

Yes thats the point. He has learnt that and therefor he is ignoring
_all_ -rc versions.

tglx


