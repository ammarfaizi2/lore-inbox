Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269227AbUIICgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269227AbUIICgZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 22:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269230AbUIICgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 22:36:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11463 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269227AbUIICgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 22:36:21 -0400
Subject: Re: Major XFS problems...
From: Greg Banks <gnb@melbourne.sgi.com>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Anando Bhattacharya <a3217055@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040908173037.GI390@unthought.net>
References: <20040908123524.GZ390@unthought.net>
	 <322909db040908080456c9f291@mail.gmail.com>
	 <20040908154434.GE390@unthought.net>
	 <1094661418.19981.36.camel@hole.melbourne.sgi.com>
	 <20040908173037.GI390@unthought.net>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1094697743.19981.65.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 09 Sep 2004 12:42:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 03:30, Jakob Oestergaard wrote:
> On Thu, Sep 09, 2004 at 02:36:58AM +1000, Greg Banks wrote:
> > On Thu, 2004-09-09 at 01:44, Jakob Oestergaard wrote:
> Ok - Anders (as@cohaesio.com) will hopefully get a test setup (similar
> to the big server) running tomorrow, and will then see if the system can
> be broken with these two patches applied.

Thanks, that will be a useful data point for Nathan.

> Are we right in assuming that no other patches should be necessary atop
> of 2.6.8.1 in order to get a stable XFS?   (that we should not apply
> other XFS specific patches?)

Sorry, I didn't mean to be unclear.  I'm merely a user of XFS and
am in no position to make a statement except that "it works for me"
with the usual caveat that my platform and workload may differ.

However, I do work on NFS for a living and can point out that in 
the 2.6 SMP case there have been issues with the unnatural acts
knfsd needs to perform upon the dcache, and that these might be
factors in the problems you're seeing.  In particular, the stack
traces I've seen just might be caused by dcache confusion caused
by one of the bugs I've mentioned.  Or not.

I just wanted to point out that there are more potential sources
of bugs in your setup than just XFS.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


