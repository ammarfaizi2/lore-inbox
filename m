Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVIER1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVIER1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 13:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVIER1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 13:27:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:23787 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932318AbVIER1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 13:27:43 -0400
Date: Mon, 5 Sep 2005 22:57:14 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905172714.GB9132@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905084425.B24051@flint.arm.linux.org.uk> <20050905170424.GK25856@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905170424.GK25856@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 10:04:24AM -0700, Nishanth Aravamudan wrote:
> > However, we could change "handler" to be a function pointer which
> > returns the number of missed ticks instead, and then updates the
> > kernels time and tick keeping.  That would probably be more efficient.
> 
> Yes, I think
> 
> unsigned long (*recover_time)(int, void *, struct pt_regs *);
> 
> or something similar (not sure about the params), might be more
> appropriate.

What would this be for x86? This could be cur_timer->mark_offset()
itself for now i think, until John's TOD comes along.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
