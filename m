Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266278AbTIEUjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266297AbTIEUjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:39:08 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27922
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S266278AbTIEUi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:38:58 -0400
Date: Fri, 5 Sep 2003 13:39:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
Message-ID: <20030905203903.GF19041@matchmail.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <207340000.1062793164@flay>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 01:19:24PM -0700, Martin J. Bligh wrote:
> > On Fri, Sep 05, 2003 at 11:54:04AM -0700, Martin J. Bligh wrote:
> >> > Backboost is gone so X really should be at -10 or even higher.
> >> 
> >> Wasn't that causing half the problems originally? Boosting X seemed
> >> to starve xmms et al. Or do the interactivity changes fix xmms
> >> somehow, but not X itself? Explicitly fiddling with task's priorities
> >> seems flawed to me.
> > 
> > Wasn't it the larger timeslices with lower nice values in stock and Con's
> > patches that made X with nice -10 a bad idea?
> 
> Debian renices X by default to -10 ... I fixed all my desktop interactivity
> problems around 2.5.63 timeframe by just turning that off. That was way 
> before Con's patches.

Exactly.  Because the larger time slices for lower nice values came from
O(1), not Con.

> 
> There may be some more details around this, and I'd love to hear them,
> but I fundmantally believe that explitit fiddling with particular
> processes because we believe they're somehow magic is wrong (and so
> does Linus, from previous discussions).
> 

Linus added a patch to 2.5.65 or so that was supposed to allow nice 0 on X
without any detrament. 
