Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422840AbWHYTpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422840AbWHYTpR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422865AbWHYTpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:45:16 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:56129 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1422840AbWHYTpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:45:14 -0400
X-IronPort-AV: i="4.08,169,1154934000"; 
   d="scan'208"; a="314149322:sNHT32016568"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 23] IB/ipath - More changes to support InfiniPath on PowerPC 970 systems
X-Message-Flag: Warning: May contain useful information
References: <44809b730ac95b39b672.1156530266@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 25 Aug 2006 12:45:12 -0700
In-Reply-To: <44809b730ac95b39b672.1156530266@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 25 Aug 2006 11:24:26 -0700")
Message-ID: <adabqq8tx9z.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Aug 2006 19:45:13.0416 (UTC) FILETIME=[FB4C6480:01C6C87E]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How did you generate these patches?  When I try to apply them with
git, I get errors like

    error: drivers/infiniband/hw/ipath/Makefile	Fri Aug 25 11:19:44 2006 -0700: No such file or directory

because the line

diff --git a/drivers/infiniband/hw/ipath/Makefile b/drivers/infiniband/hw/ipath/Makefile

makes git think it's a git diff, but git doesn't put dates on the
filename lines.  In other words, instead of

--- a/drivers/infiniband/hw/ipath/Makefile	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/Makefile	Fri Aug 25 11:19:44 2006 -0700

the patch should just have

--- a/drivers/infiniband/hw/ipath/Makefile
+++ b/drivers/infiniband/hw/ipath/Makefile

before the Makefile chunks.

I fixed this up by deleting the "diff --git" lines, but I'm curious
how you created this in the first place.

 - R.
