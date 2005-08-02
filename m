Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVHBRKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVHBRKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 13:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVHBRKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 13:10:52 -0400
Received: from galileo.bork.org ([134.117.69.57]:11419 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261670AbVHBRKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 13:10:50 -0400
Date: Tue, 2 Aug 2005 13:10:50 -0400
From: Martin Hicks <mort@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, mort@sgi.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch] remove sys_set_zone_reclaim()
Message-ID: <20050802171050.GG26803@localhost>
References: <20050801113913.GA7000@elte.hu> <20050801102903.378da54f.akpm@osdl.org> <20050801195426.GA17548@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801195426.GA17548@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Aug 01, 2005 at 09:54:26PM +0200, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  We could perhaps add a CAP_SYS_ADMIN-only sysctl for this hack,
> > 
> > That would be more appropriate.
> > 
> > (I'm still not sure what happened to the idea of adding a call to 
> > "clear out this node+zone's pagecache now" rather than "set this 
> > noed+zone's policy")
> 
> lets do that as a sysctl hack. It would be useful for debugging purposes 
> anyway. But i'm not sure whether it's the same issue - Martin?

(Sorry..I was on vacation yesterday)

Yes, this is the same issue with a different way of making it happen.
Setting a zone's policy allows reclaim to happen automatically.

I'll send in a patch to add a sysctl to do the manual dumping of
pagecache really soon.

mh

-- 
Martin Hicks   ||   Silicon Graphics Inc.   ||   mort@sgi.com
