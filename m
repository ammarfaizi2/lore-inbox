Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUGHQGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUGHQGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUGHQGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:06:31 -0400
Received: from cm217.omega59.maxonline.com.sg ([218.186.59.217]:37510 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264538AbUGHQGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:06:17 -0400
Date: Fri, 9 Jul 2004 00:06:22 +0800
From: David Teigland <teigland@redhat.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org, Daniel Phillips <phillips@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040708160622.GF19550@redhat.com>
References: <20040708105338.GA16115@redhat.com> <40ED56D0.1020102@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ED56D0.1020102@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >I'm afraid the fencing issue has been rather misrepresented.  Here's what
> >we're doing (a lot of background is necessary I'm afraid.)  We have a
> >symmetric, kernel-based, stand-alone cluster manager (CMAN) that has no ties
> >to anything else whatsoever.  It'll simply run and answer the question
> >"who's in the cluster?" by providing a list of names/nodeids.
> >
> >So, if that's all you want you can just run cman on all your nodes and it'll
> >tell you who's in the cluster (kernel and userland api's).  CMAN will also
> >do generic callbacks to tell you when the membership has changed.  Some
> >people can stop reading here.
> 
> I'm curious--this seems to be exactly what the cluster membership portion of
> the SAF spec provides.  Would it make sense to contribute to that portion of
> OpenAIS, then export the CMAN API on top of it for backwards compatibility?

That's definately worth investigating.  If the SAF API is only of interest in
userland, then perhaps a library can translate between the SAF api and the
existing interface cman exports to userland.  We'd welcome efforts to make cman
itself more compatible with SAF, too.  We're not very familiar with it, though.


> It just seems like there are a bunch of different cluster messaging,
> membership, etc. systems, and there is a lot of work being done in parallel
> with different implementations of the same functionality.  Now that there is
> a standard emerging for clustering (good or bad, we've got people asking for
> it) would it make sense to try and get behind that standard and try and make
> a reference implementation?
> 
> You guys are more experienced than I, but it seems a bit of a waste to see
> all these projects re-inventing the wheel.

Sure, we're happy to help make this code more useful to others.  We wrote this
for a very immediate and practical reason of course -- to support gfs, clvm,
dlm, etc, but always expected it would be used more broadly.  We've not done a
lot of work with it lately since as I mentioned it was begun years ago.

-- 
Dave Teigland  <teigland@redhat.com>
