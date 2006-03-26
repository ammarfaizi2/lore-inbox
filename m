Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWCZWIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWCZWIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWCZWIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:08:25 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20891 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751124AbWCZWIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:08:24 -0500
Date: Mon, 27 Mar 2006 08:08:11 +1000
From: Nathan Scott <nathans@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: Re: kernel BUG at fs/direct-io.c:916!
Message-ID: <20060327080811.D753448@wobbly.melbourne.sgi.com>
References: <20060326180440.GA4776@charite.de> <20060326184644.GC4776@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060326184644.GC4776@charite.de>; from Ralf.Hildebrandt@charite.de on Sun, Mar 26, 2006 at 08:46:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 08:46:44PM +0200, Ralf Hildebrandt wrote:
> * Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> > Today I wanted to run xfs_fsr on my laptop. I got:
> 
> It's a 2.6.16-mm1 issue, since 2.6.16-git11 does not exhibit that
> failure.
> 
> > Linux knarzkiste 2.6.16-mm1 #1 PREEMPT Fri Mar 24 19:01:24 CET 2006  i686 GNU/Linux

Hmm, there were XFS patches in -mm last week, but they also got
merged to mainline last week, not clear whether your git kernel
had those changes or not.  I think there's probably some direct
I/O (generic) changes in -mm too based on list traffic from the
last couple of weeks (I'm an -mm lamer, sorry, couldn't easily
tell you exactly what patches those might be) - could you retry
with todays git snapshot and see if mainline is affected?  Else
we'll need to find and analyse any -mm fs/direct-io.c patches.

cheers.

-- 
Nathan
