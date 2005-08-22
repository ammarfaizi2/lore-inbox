Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbVHVWkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbVHVWkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbVHVWkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:40:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751484AbVHVWkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:40:10 -0400
Date: Mon, 22 Aug 2005 15:38:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: tony.luck@intel.com
Cc: davem@davemloft.net, jasonuhl@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK_TIME woes
Message-Id: <20050822153838.186ac336.akpm@osdl.org>
In-Reply-To: <200508222233.j7MMXGWj020872@agluck-lia64.sc.intel.com>
References: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
	<20050822.132052.65406121.davem@davemloft.net>
	<20050822203306.GA897956@dragonfly.engr.sgi.com>
	<20050822.134226.35468933.davem@davemloft.net>
	<200508222233.j7MMXGWj020872@agluck-lia64.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tony.luck@intel.com wrote:
>
> >How fast is printk?  I haven't looked.
> >
> >ie: if you do back-to-back printk's, what's the timestamp increment?
> 
> On ia64 it looks like about 4-5 usec increment for back-to-back
> printk (with no serial console configured, and dmesg -n to turn
> off messages to the VGA console).
> 

Ah, thanks.  Presumably it'll be considerably longer with %d's and %s's in
there.  But still, ~10 usecs is good resolution for I/O operations.
