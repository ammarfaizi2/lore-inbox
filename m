Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270728AbTGUVTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270741AbTGUVTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:19:35 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:28832 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270728AbTGUVRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:17:12 -0400
Date: Mon, 21 Jul 2003 14:31:59 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@bitmover.com>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-ID: <20030721213159.GA7240@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <20030721190226.GA14453@matchmail.com> <20030721194514.GA5803@work.bitmover.com> <20030721212155.GF4677@x30.linuxsymposium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721212155.GF4677@x30.linuxsymposium.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 05:21:55PM -0400, Andrea Arcangeli wrote:
> Hi Larry,
> 
> On Mon, Jul 21, 2003 at 12:45:14PM -0700, Larry McVoy wrote:
> > You don't need the tags, use dates.  You can get the date range you want 
> > with an rlog of the ChangeSet file and then use those dates.
> 
> I realized I could do this, and it can of course be automated with an
> additional bkcvs specific hack in cvsps. But the tag in every file would
> have kept the functionality generic with the already available -r
> option, and since I can't see any downside in the tag in the files, I
> prefer that generic way.

The tags means that each file gets modified for each tag and then we have
to transfer the whole tree after a tag.  It thrashes the hell out of the
disk too, for no good reason.

Also note that there are nowhere near as many tags as there are commits
in the CVS tree.  So by using tags you are restricting yourself to coarse
granularity in your bug hunts.

> But if you're sure the tags aren't coming back we can start adding the
> automation to cvsps.

Please do, we're not adding the tags.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
