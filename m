Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWEIU0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWEIU0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWEIU0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:26:10 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:4482 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751132AbWEIU0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:26:09 -0400
Date: Tue, 9 May 2006 13:28:50 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.15
Message-ID: <20060509202850.GQ24291@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.15
kernel.  Fixes for SCTP security issues.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.14 and 2.6.16.15, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                   |    2 -
 include/net/sctp/structs.h |    1 
 net/sctp/inqueue.c         |    1 
 net/sctp/sm_statefuns.c    |   59 +++++++++++++++++++++++++++++++++------------
 net/sctp/sm_statetable.c   |   10 +++----
 net/sctp/ulpqueue.c        |   27 +++++++++++++++++++-
 6 files changed, 77 insertions(+), 23 deletions(-)

Summary of changes from v2.6.16.14 to v2.6.16.15
================================================

Chris Wright:
      Linux 2.6.16.15

Neil Horman:
      SCTP: Allow spillover of receive buffer to avoid deadlock. (CVE-2006-2275)

Sridhar Samudrala:
      SCTP: Fix panic's when receiving fragmented SCTP control chunks. (CVE-2006-2272)
      SCTP: Fix state table entries for chunks received in CLOSED state. (CVE-2006-2271)

Vladislav Yasevich:
      SCTP: Prevent possible infinite recursion with multiple bundled DATA. (CVE-2006-2274)

