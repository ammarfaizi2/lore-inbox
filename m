Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVGNP5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVGNP5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 11:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVGNP5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 11:57:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8688 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262832AbVGNP5H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 11:57:07 -0400
Subject: Re: RT and XFS
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Chinner <dgc@sgi.com>, greg@kroah.com, Nathan Scott <nathans@sgi.com>,
       Steve Lord <lord@xfs.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
In-Reply-To: <20050714052347.GA18813@elte.hu>
References: <1121209293.26644.8.camel@dhcp153.mvista.com>
	 <20050713002556.GA980@frodo> <20050713064739.GD12661@elte.hu>
	 <1121273158.13259.9.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050714002246.GA937@frodo> <20050714135023.E241419@melbourne.sgi.com>
	 <1121314226.14816.18.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050714052347.GA18813@elte.hu>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 08:56:58 -0700
Message-Id: <1121356618.14816.45.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 07:23 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > > The whole point of using a semaphore in the pagebuf is because there
> > > is no tracking of who "owns" the lock so we can actually release it
> > > in a different context. Semaphores were invented for this purpose,
> > > and we use them in the way they were intended. ;)
> > 
> > Where is the that semaphore spec, is that posix ?  There is a new 
> > construct called "complete" that is good for this type of stuff too. 
> > No owner needed , just something running, and something waiting till 
> > it completes.
> 
> wrt. posix, we dont really care about that for kernel-internal 
> primitives like struct semaphore. So whether it's posix or not has no 
> relevance.

This reminds me of Documentation/stable_api_nonsense.txt . That no one
should really be dependent on a particular kernel API doing a particular
thing. The kernel is play dough for the kernel hacker (as it should be),
including kernel semaphores.

So we can change whatever we want, and make no excuses, as long as we
fix the rest of the kernel to work with our change. That seems pretty
sensible , because Linux should be an evolution. 

Daniel

