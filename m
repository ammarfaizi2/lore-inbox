Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVECQgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVECQgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVECQgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:36:47 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:24231 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261297AbVECQgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:36:43 -0400
Date: Tue, 3 May 2005 12:36:28 -0400
To: "William A.(Andy) Adamson" <andros@citi.umich.edu>
Cc: Michael Kerrisk <michael.kerrisk@gmx.net>, matthew@wil.cx,
       sfr@canb.auug.org.au, mtk-lkml@gmx.net, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question
Message-ID: <20050503163628.GB24293@fieldses.org>
References: <20050503141552.F42371BAD1@citi.umich.edu> <5531.1115131813@www41.gmx.net> <20050503162124.500F01BB40@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503162124.500F01BB40@citi.umich.edu>
User-Agent: Mutt/1.5.9i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 12:21:24PM -0400, William A.(Andy) Adamson wrote:
> the other side of the coin would be break_lease.

Yeah, I'm a little confused as to why anyone would have the expectation
that read leases would not conflict with write opens by the same
process, given that break_lease() has never functioned that way, so
later write opens by the same process have always broken any read lease.

Are there applications that actually depend on the old behaviour?  Is
there any documentation that blesses it?  All I can find is the fcntl
man page, and as far as I can tell an implementation that makes read
leases conflict with all write opens (by the same process or not) is
consistent with that man page.

--b.
