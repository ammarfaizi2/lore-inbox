Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUJHFVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUJHFVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 01:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267766AbUJHFVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 01:21:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:12211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267745AbUJHFV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 01:21:26 -0400
Date: Thu, 7 Oct 2004 22:21:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, chrisw@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-ID: <20041007222119.X2357@build.pdx.osdl.net>
References: <20041007164044.23bac609.akpm@osdl.org> <4165E0A7.7080305@yahoo.com.au> <20041007174242.3dd6facd.akpm@osdl.org> <20041007184134.S2357@build.pdx.osdl.net> <20041007185131.T2357@build.pdx.osdl.net> <20041007185352.60e07b2f.akpm@osdl.org> <4165FF7B.1070302@cyberone.com.au> <20041007200109.57ce24ae.akpm@osdl.org> <416605CC.2080204@cyberone.com.au> <20041007203048.298029ab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041007203048.298029ab.akpm@osdl.org>; from akpm@osdl.org on Thu, Oct 07, 2004 at 08:30:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris, do you have time to test this, against -linus?

Yeah.  This patch held up against the simple testing, as did Nick's (not
the most recent combined one from him).

Here's some sample output from annotation I added:

balance_pgdat:1050: zone->DMA present_pages == 0
balance_pgdat:1050: zone->DMA present_pages == 0
balance_pgdat:1050: zone->DMA present_pages == 0
balance_pgdat:1050: zone->DMA present_pages == 0
balance_pgdat:1013: zone->DMA present_pages == 0
balance_pgdat:1050: zone->DMA present_pages == 0
balance_pgdat:1050: zone->DMA present_pages == 0
balance_pgdat:1050: zone->DMA present_pages == 0

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
