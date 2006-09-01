Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWIAUvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWIAUvg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 16:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWIAUvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 16:51:36 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:13759 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750798AbWIAUvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 16:51:35 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile error
X-Message-Flag: Warning: May contain useful information
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org> <adak64nij8f.fsf@cisco.com>
	<20060901112312.5ff0dd8d.akpm@osdl.org> <ada8xl3ics4.fsf@cisco.com>
	<20060901130444.48f19457.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 01 Sep 2006 13:51:32 -0700
In-Reply-To: <20060901130444.48f19457.akpm@osdl.org> (Andrew Morton's message of "Fri, 1 Sep 2006 13:04:44 -0700")
Message-ID: <ada4pvria3v.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2006 20:51:33.0437 (UTC) FILETIME=[6877A6D0:01C6CE08]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> No, driver-specific workarounds are not legitimate, sorry.

    Andrew> The driver should simply fail to compile on architectures
    Andrew> which do not implement __raw_writeq().

But how should i386 (say) implement __raw_writeq()?  As two
__raw_writel()s protected by a spinlock (that serializes all IO
transactions)?  That seems rather ugly.

 - R.

-- 
VGER BF report: H 0
