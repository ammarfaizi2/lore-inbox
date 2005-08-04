Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVHDEsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVHDEsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 00:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVHDErD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 00:47:03 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:4221 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S261716AbVHDEoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 00:44:38 -0400
X-IronPort-AV: i="3.95,166,1120460400"; 
   d="scan'208"; a="328822826:sNHT29395594"
To: yhlu <yhlu.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: mthca and LinuxBIOS (was: [PATCH 1/2] [IB/cm]: Correct CM port
 redirect reject codes)
X-Message-Flag: Warning: May contain useful information
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	<20057281331.7vqhiAJ1Yc0um2je@cisco.com>
	<86802c44050803175873fb0569@mail.gmail.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 03 Aug 2005 21:44:32 -0700
In-Reply-To: <86802c44050803175873fb0569@mail.gmail.com> (yhlu's message of
 "Wed, 3 Aug 2005 17:58:11 -0700")
Message-ID: <52u0i6b9an.fsf_-_@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Aug 2005 04:44:32.0797 (UTC) FILETIME=[3520D4D0:01C598AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    yhlu> In LinuxBIOS, If I enable the prefmem64 to use real 64
    yhlu> range. the IB driver in Kernel can not be loaded.

What does it mean to "enable the prefmem64 to use real 64 range"?

Does the driver work if you don't do this?

    yhlu> ib_mthca 0000:04:00.0: Failed to initialize queue pair table, aborting.

Can you add printk()s to mthca_qp.c::mthca_init_qp_table() to find out
how far the function gets before it fails?

It would also be useful for you to build with CONFIG_INFINIBAND_MTHCA_DEBUG=y
and send the kernel output you get with that.

 - Roland
