Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292784AbSCDTHK>; Mon, 4 Mar 2002 14:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292783AbSCDTGw>; Mon, 4 Mar 2002 14:06:52 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:7319 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292770AbSCDTGs>;
	Mon, 4 Mar 2002 14:06:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>,
        James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Mon, 4 Mar 2002 20:02:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <200203041457.g24EvvU01682@localhost.localdomain> <1210360000.1015262682@tiny>
In-Reply-To: <1210360000.1015262682@tiny>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hxjE-0000fF-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 06:24 pm, Chris Mason wrote:
> On Monday, March 04, 2002 08:57:57 AM -0600 James Bottomley wrote:
> >> 2a) Are the filesystems asking for something impossible?  Can drives
> >> really write block N and N+1, making sure to commit N to media before
> >> N+1 (including an abort on N+1 if N fails), but still keeping up a
> >> nice seek free stream of writes? 
> > 
> > These are the "big" issues.  There's not much point doing all the work to 
> > implement ordered tags, if the end result is going to be no gain in 
> > performance.
> 
> Right, 2a seems to be the show stopper to me.  The good news is 
> the existing patches are enough to benchmark the thing and see if
> any devices actually benefit.  If we find enough that do, then it
> might be worth the extra driver coding required to make the code
> correct.

Waiting with breathless anticipation.  And once these issues are worked out, 
there's a tough one remaining: enforcing the write barrier through a virtual 
volume with multiple spindles underneath with separate command queues, so 
that the write barrier applies to all.

-- 
Daniel
