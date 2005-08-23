Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVHWBuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVHWBuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 21:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVHWBuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 21:50:14 -0400
Received: from ozlabs.org ([203.10.76.45]:7101 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751280AbVHWBuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 21:50:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17162.33144.590028.796896@cargo.ozlabs.ibm.com>
Date: Tue, 23 Aug 2005 11:52:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: tony.luck@intel.com
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, jasonuhl@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK_TIME woes
In-Reply-To: <200508222327.j7MNRSBR020922@agluck-lia64.sc.intel.com>
References: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
	<20050822.132052.65406121.davem@davemloft.net>
	<20050822203306.GA897956@dragonfly.engr.sgi.com>
	<20050822.134226.35468933.davem@davemloft.net>
	<200508222233.j7MMXGWj020872@agluck-lia64.sc.intel.com>
	<200508222327.j7MNRSBR020922@agluck-lia64.sc.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tony.luck@intel.com writes:

> Earlier I said that it would be possible to provide a simplified
> do_gettimeofday() call that met the no locks requirement.  I still
> think this is possible, but most architectures would only get
> jiffie resolution from this (only ia64, sparc64 and HPET users
> have time interpolators registered).

ppc64 has a lockless do_gettimeofday() with microsecond resolution.

Paul.
