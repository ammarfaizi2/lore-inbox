Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266823AbTGKVMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbTGKVMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:12:17 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:48087 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S266823AbTGKVMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:12:08 -0400
Date: Fri, 11 Jul 2003 14:26:45 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ben Collins <bcollins@debian.org>
Cc: Larry McVoy <lm@bitmover.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Strange BK behaviour?
Message-ID: <20030711212645.GA17601@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ben Collins <bcollins@debian.org>, Larry McVoy <lm@bitmover.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307111715400.5537@freak.distro.conectiva> <20030711205532.GB17804@work.bitmover.com> <20030711195440.GY439@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711195440.GY439@phunnypharm.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 03:54:40PM -0400, Ben Collins wrote:
> On Fri, Jul 11, 2003 at 01:55:32PM -0700, Larry McVoy wrote:
> > Ahh, it's there, bkbits just isn't showing it because it is an empty merge
> > changeset.  That's a bug.  If you care, file a bug on bk/web with a 
> > summary like "show merge changesets if they are tagged".
> 
> It definitely got down to CVS/SVN.

Right, the data is there.  There is a lot of "merge noise" in BK where BK
is just recording the fact that changes in unrelated files have been 
brought together.  In general, you don't want to see all that noise, it's
more or less internal BK metadata.  So BK/Web filters it out, as does
bk changes.  But in this case, because the cset in question is "named"
with a tag it should have been shown.

It's a presentation issue, not a data problem, which is why CVS/SVN saw 
it - the exporter works on the raw data.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
