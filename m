Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757138AbWKVXEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757138AbWKVXEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757143AbWKVXEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:04:07 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:50203 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1757138AbWKVXEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:04:04 -0500
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, raisch@de.ibm.com
Subject: Re: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe address to determine pending work requests
X-Message-Flag: Warning: May contain useful information
References: <200611202354.13030.hnguyen@linux.vnet.ibm.com>
	<adaslgcg30n.fsf@cisco.com>
	<200611221029.10077.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 22 Nov 2006 15:04:01 -0800
In-Reply-To: <200611221029.10077.hnguyen@linux.vnet.ibm.com> (Hoang-Nam Nguyen's message of "Wed, 22 Nov 2006 10:29:09 +0100")
Message-ID: <adaslgbaxsu.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Nov 2006 23:04:01.0291 (UTC) FILETIME=[7FA16DB0:01C70E8A]
Authentication-Results: sj-dkim-7; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim7002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > We found this bug actually through a code review by random. Since
 > (un)fortunately the queue pages were layouted in order, we've not
 > seen it earlier. It's certainly a bug and can cause kernel panic 
 > if above observation is not met, probably in stress situation
 > of system. That means the "former" code accesses next page that 
 > it has not allocated.

OK.  After thinking about this, I'm going to queue it for 2.6.20 --
we're _way_ too close to the 2.6.19 final release to put in patches
that aren't either small and obvious, or fix a problem someone hit in
real life.

 - R.
