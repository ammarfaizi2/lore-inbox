Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269338AbTGJPEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269341AbTGJPEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:04:10 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:59111 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S269338AbTGJPEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:04:05 -0400
Date: Thu, 10 Jul 2003 08:15:07 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Larry McVoy <lm@bitmover.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Ben Collins <bcollins@debian.org>, linux-kernel@vger.kernel.org,
       Wayne Scott <wscott@bitmover.com>
Subject: Re: Linux 2.4.22-pre3
Message-ID: <20030710151507.GA27605@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
	Larry McVoy <lm@bitmover.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Ben Collins <bcollins@debian.org>, linux-kernel@vger.kernel.org,
	Wayne Scott <wscott@work.bitmover.com>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva> <20030706134156.GG502@phunnypharm.org> <Pine.LNX.4.55L.0307062157300.30827@freak.distro.conectiva> <20030707010527.GA30154@work.bitmover.com> <20030708180520.GJ6848@fs.tum.de> <20030708191817.GB17115@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708191817.GB17115@gtf.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 03:18:17PM -0400, Jeff Garzik wrote:
> On Tue, Jul 08, 2003 at 08:05:21PM +0200, Adrian Bunk wrote:
> > On Sun, Jul 06, 2003 at 06:05:27PM -0700, Larry McVoy wrote:
> > > On Sun, Jul 06, 2003 at 10:00:34PM -0300, Marcelo Tosatti wrote:
> > > > On Sun, 6 Jul 2003, Ben Collins wrote:
> > > > > Any chance you could be consistent in tagging the -pre's? Neither pre2,
> > > > > nor pre3 is tagged in BK, and thus, not tagged in CVS/SVN either.
> > > > 
> > > > I guess I have tagged -pre2 and -pre3:
> > > > 
> > > > Maybe I'm missing something?
> > > 
> > > Hmm.   Ben, look again in the CVS tree and make sure that the tags aren't
> > > there.  Maybe the converter screwed up?  
> > 
> > -pre2 and -pre3 are also missing at
> >   http://ftp.kernel.org/pub/linux/kernel/v2.4/testing/cset/
> 
> hrm.  Well, it's definitely tagged correctly in Marcelo's main 2.4 BK
> repo.

I think I've found the bug - it's in the code that collapses multiple 
changesets into one CVS checkin.  It looks like we are picking up 
tags only if the tag was on the last changeset in the sequence instead
of any changeset in the sequence.  We're fixing it.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
