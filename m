Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVEaPXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVEaPXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVEaPXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:23:45 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:29843 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261902AbVEaPXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:23:43 -0400
Date: Tue, 31 May 2005 11:23:28 -0400
To: Michael Kerrisk <michael.kerrisk@gmx.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, mtk-lkml@gmx.net,
       heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       andros@citi.umich.edu, matthew@wil.cx, schwidefsky@de.ibm.com
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question
Message-ID: <20050531152328.GC22433@fieldses.org>
References: <20050503231408.7c045648.sfr@canb.auug.org.au> <32555.1117551230@www14.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32555.1117551230@www14.gmx.net>
User-Agent: Mutt/1.5.9i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 04:53:50PM +0200, Michael Kerrisk wrote:
> I applied this against 2.6.12-rc4, and it fixes the problem 
> (and I've also teasted various other facets of file leases 
> and this change causes no obvious breakage elsewhere).
> 
> Are you going to push this fix into 2.6.12?

Are you sure this is actually a problem?

I still have the following questions I had before:

> I'm a little confused as to why anyone would have the expectation
> that read leases would not conflict with write opens by the same
> process, given that break_lease() has never functioned that way, so
> later write opens by the same process have always broken any read lease.
>
> Are there applications that actually depend on the old behaviour?  Is
> there any documentation that blesses it?  All I can find is the fcntl
> man page, and as far as I can tell an implementation that makes read
> leases conflict with all write opens (by the same process or not) is
> consistent with that man page.

--b.
