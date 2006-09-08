Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752051AbWIHCdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbWIHCdy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 22:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWIHCdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 22:33:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24960 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752051AbWIHCdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 22:33:53 -0400
Date: Fri, 8 Sep 2006 12:33:39 +1000
From: David Chinner <dgc@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: Wrong free space reported for XFS filesystem
Message-ID: <20060908023339.GF10950339@melbourne.sgi.com>
References: <9a8748490609060154ye8730b0n16e23524010a35e4@mail.gmail.com> <20060906230238.GJ5737019@melbourne.sgi.com> <9a8748490609070717q6ed9111ckdc3de025dc44938b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490609070717q6ed9111ckdc3de025dc44938b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 04:17:53PM +0200, Jesper Juhl wrote:
> On 07/09/06, David Chinner <dgc@sgi.com> wrote:
> >On Wed, Sep 06, 2006 at 10:54:34AM +0200, Jesper Juhl wrote:
> >> For your information;
> >>
> >> I've been running a bunch of benchmarks on a 250GB XFS filesystem.
> >> After the benchmarks had run for a few hours and almost filled up the
> >> fs, I removed all the files and did a "df -h" with interresting
> >> results :
.....
> >So the in-core accounting has underflowed by a small amount but the
> >on disk accounting is correct.
> >
> >We've had a few reports of this that I know of over the past
> >couple of years, but we've never managed to find a reproducable
> >test case for it.
> >Can you describe what benchmark you were runnin, wht kernel you were
> >using
> 
> The kernel is 2.6.18-rc6 SMP

Ok, so it's a current problem....

> >and whether any of the tests hit  an ENOSPC condition?
> >
> That I don't know.
> 
> The script I was running is this one :

<snip>

That doesn't really narrow down the scope at all. All that script
tells me is that problem is <waves hands> somewhere inside XFS....  :/
Can you try to isolate which of the loads is causing the problem?

That being said, this looks like a good stress load - I'll pass it
onto our QA folks...

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
