Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269250AbUIIDQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269250AbUIIDQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 23:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUIIDQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 23:16:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:48593 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269250AbUIIDQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 23:16:28 -0400
Subject: Re: Major XFS problems...
From: Greg Banks <gnb@melbourne.sgi.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <chnkqd$u7n$1@gatekeeper.tmr.com>
References: <20040908154434.GE390@unthought.net>
	 <20040908123524.GZ390@unthought.net>
	 <1094661418.19981.36.camel@hole.melbourne.sgi.com>
	 <chnkqd$u7n$1@gatekeeper.tmr.com>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1094700180.19981.85.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 09 Sep 2004 13:23:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 05:06, Bill Davidsen wrote:
> Greg Banks wrote:
> > On Thu, 2004-09-09 at 01:44, Jakob Oestergaard wrote:
> > 
> >>SMP systems on 2.6 have a problem with XFS+NFS.
> > 
> > 
> > Knfsd threads in 2.6 are no longer serialised by the BKL, and the
> > change has exposed a number of SMP issues in the dcache.  Try the
> > two patches at
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=108330112505555&w=2
> > 
> > and
> > 
> > http://linus.bkbits.net:8080/linux-2.5/cset@1.1722.48.23
> > 
> > (the latter is in recent Linus kernels).  If you're still having
> > problems after applying those patches, Nathan and I need to know.
> 
> Do I read you right that this is an SMP issue and that the NFS, quota, 
> backup and all that are not relevant?

The first issue is NFS-specific.  The second one is an ancient dcache
bug from before 2.6 which NFS changes in 2.6 uncovered; however it
could affect any filesystem with or without NFS.  Neither have anything
to do with quota or backup per se, except that backup might generate
enough load to help them happen.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


