Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWBRA5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWBRA5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWBRA5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:57:13 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:38258 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751498AbWBRA5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:57:12 -0500
From: Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 00/22] [RFC] IBM eHCA InfiniBand adapter driver
Date: Fri, 17 Feb 2006 16:55:32 -0800
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org
Cc: SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Message-Id: <20060218005532.13620.79663.stgit@localhost.localdomain>
X-OriginalArrivalTime: 18 Feb 2006 00:57:03.0562 (UTC) FILETIME=[3B575AA0:01C63426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a series of patches that add an InfiniBand adapter driver
for IBM eHCA hardware.  Please look it over with an eye towards issues
that need to be addressed before merging this upstream.

This patch series is somewhat unusual in that I am not the original
author of this driver -- I am just sending it for review for the
authors, who are apparently not able to post patches themselves due to
internal issues at IBM.  However they are cc'ed and will respond to
comments in this thread.

In fact I have some issues with the code myself that need to be
addressed before this driver is mergeable.  I've included most of them
in the individual patches, although I have some general comments too.
However I would like to get some early feedback for the ehca authors
from the wider community.  In particular I think its important to run
this past the ppc64 experts, since I'm not sure what the standards for
this sort of pSeries driver are.

Anyway, my general comments:

 - The #ifs that test EHCA_USERDRIVER and __KERNEL__ should be killed.
   We know that this is kernel code, so there's no reason to include
   userspace compatibility junk.

 - Many of the comments look like they are for some automatic
   documentation system that is not quite kerneldoc.  They should be
   fixed to be real kerneldoc comments.

 - In general there is a huge amount of code in large inline functions
   in .h files.  Things should be reorganized to cut this down to a
   sane amount.

Thanks,
  Roland
