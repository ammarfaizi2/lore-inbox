Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWEOPxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWEOPxq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWEOPxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:53:46 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:53139 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751553AbWEOPxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:53:45 -0400
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="1806309239:sNHT30013546"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35 of 53] ipath - some interrelated stability and cleanliness fixes
X-Message-Flag: Warning: May contain useful information
References: <e29625bd905036ab3175.1147477400@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 08:53:44 -0700
In-Reply-To: <e29625bd905036ab3175.1147477400@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 12 May 2006 16:43:20 -0700")
Message-ID: <ada8xp3uvw7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 15:53:44.0606 (UTC) FILETIME=[BEC9ABE0:01C67837]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like a pastiche of several patches.  Why can't it be split
up into logical pieces?

 > Call dma_free_coherent without ipath_mutex held.

Why?  Doesn't freeing work with the mutex held?

 - R.
