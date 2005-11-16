Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbVKPNKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbVKPNKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbVKPNKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:10:24 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:10161 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965250AbVKPNKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:10:23 -0500
Date: Wed, 16 Nov 2005 07:10:12 -0600
From: Robin Holt <holt@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>, Russ Anderson <rja@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: How to handle a hugepage with bad physical memory?
Message-ID: <20051116131012.GE4573@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel,

Russ Anderson recently introduced a patch into ia64 that changes MCA
behavior.  When the MCA is caused by a user reference to a users memory,
we put an extra reference on the page and kill the user.  This leaves
the working memory available for other jobs while causing a leak of the
bad page.

I don't know if Russ has done any testing with hugetlbfs pages.  I preface
the remainder of my comments with a huge "I don't know anything"
disclaimer.

With the new hugepages concept, would it be possible to only mark
the default pagesize portion of a hugepage as bad and then return the
remainder of the hugepage for normal use?  What would we basically need
to do to accomplish this?  Are there patches in the community which we
should wait to see how they progress before we do any work on this front?

Thanks,
Robin Holt
