Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755561AbWKVJZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbWKVJZJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 04:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755563AbWKVJZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 04:25:08 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:5529 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1755573AbWKVJZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 04:25:06 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe address to determine pending work requests
Date: Wed, 22 Nov 2006 10:29:09 +0100
User-Agent: KMail/1.8.2
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, raisch@de.ibm.com
References: <200611202354.13030.hnguyen@linux.vnet.ibm.com> <adaslgcg30n.fsf@cisco.com>
In-Reply-To: <adaslgcg30n.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221029.10077.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2nd try, since I forgot to post this on the mailing list)
On Tuesday 21 November 2006 17:47, Roland Dreier wrote:
> Umm, it's really late to merge things for 2.6.19.  How severe is this
> bug?  Why has it not been found until now if it causing crashes?
We found this bug actually through a code review by random. Since
(un)fortunately the queue pages were layouted in order, we've not
seen it earlier. It's certainly a bug and can cause kernel panic 
if above observation is not met, probably in stress situation
of system. That means the "former" code accesses next page that 
it has not allocated.
Thanks
Nam
