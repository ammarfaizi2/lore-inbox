Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932665AbVLBBIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbVLBBIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbVLBBIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:08:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49563 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932665AbVLBBIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:08:10 -0500
Date: Thu, 1 Dec 2005 17:06:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: tglx@linutronix.de, hch@infradead.org, mingo@elte.hu,
       rmk+lkml@arm.linux.org.uk, ray-gmail@madrabbit.org,
       zippel@linux-m68k.org, linux-kernel@vger.kernel.org, george@mvista.com,
       johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
Message-Id: <20051201170642.71803873.akpm@osdl.org>
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
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
> On Dec 01, 2005, at 19:02, Thomas Gleixner wrote:
> > On Thu, 2005-12-01 at 22:15 +0000, Christoph Hellwig wrote:
> >> Heh, in my dumb non-native speaker mind I'd expectit the other way  
> >> around, as in a timeout is expected to time out :)  and a timer is  
> >> expect to happen, as in say the timer the tells you your breakfast  
> >> egg is ready.
> >
> > Which is perfectly the point Kyle made.
> 
> In any case, the real important note here is that the two are pretty  
> different concepts, ones that lend themselves to _very_ different  
> optimizations, that are currently lumped together.  The very fact  
> that some developers easily get them confused says that we need a  
> good clean implementation of both distinct APIs with comparable  
> documentation, including a bunch of good example usages.
> 

Or just leave the timer_lists as they are.

If I'm going to spend the next two years buried in helpful
s/timer_list/ktimeout/ patches then there'd better be a darn good reason
for the rename, thanks.  I don't see one.
