Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269570AbUJGAI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269570AbUJGAI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269540AbUJGAFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:05:16 -0400
Received: from waste.org ([209.173.204.2]:18307 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269603AbUJGAC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 20:02:29 -0400
Date: Wed, 6 Oct 2004 19:02:07 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, mingo@redhat.com, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org, judith@osdl.org
Subject: Re: new dev model (was Re: Default cache_hot_time value back to 10ms)
Message-ID: <20041007000207.GV5414@waste.org>
References: <416374D5.50200@yahoo.com.au> <20041005215116.3b0bd028.akpm@osdl.org> <41637BD5.7090001@yahoo.com.au> <20041005220954.0602fba8.akpm@osdl.org> <416380D7.9020306@yahoo.com.au> <20041005223307.375597ee.akpm@osdl.org> <41638E61.9000004@pobox.com> <20041005233958.522972a9.akpm@osdl.org> <41644A3D.4050100@pobox.com> <41644BF1.7030904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41644BF1.7030904@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 03:48:01PM -0400, Jeff Garzik wrote:
> 
> So my own suggestions for increasing 2.6.x stability are:
> 
> 1) Create a release numbering system that is __clear to users__, not 
> just developers.  This is a human, not technical problem.  Telling users 
> "oh, -rc1 doesn't really mean Release Candidate, we start getting 
> serious around -rc2 or so but some stuff slips in and..." is hardly clear.

The 2.4 system Marcelo used did this nicely.. A couple -preX to shove
in new stuff, and a couple -rcX to iron out the bugs. 2.6.x-rc[12]
seem to be similar in content to 2.4.x-pre - little expectaction that
they're actually candidates for release.
 
> 2) Really (underscore underscore) only accept bugfixes after the chosen 
> line of demarcation.  No API changes.  No new stuff (new stuff may not 
> break anything, but it's a distraction).  Chill out on all the sparse 
> notations.  _Just_ _bug_ _fixes_.  The fluff (comments/sparse/new 
> features) just serves to make reviewing the changes more difficult, as 
> it vastly increases the noise-to-signal ratio.

Also, please simply rename the last -rcX for the release as Marcelo
does with 2.4. Slipping in new stuff between the candidate and the
release invalidates the testing done on the candidate so someone can't
look at 2.6.9 and say "this looks solid from 2 weeks as a release
candidate, I can run with it today".

-- 
Mathematics is the supreme nostalgia of our time.
