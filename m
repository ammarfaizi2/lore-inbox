Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUEKUTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUEKUTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUEKUTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:19:55 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:37644 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263585AbUEKUTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:19:53 -0400
Date: Tue, 11 May 2004 21:19:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, geoff@linux.jf.intel.com,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-ID: <20040511211950.A20071@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	geoff@linux.jf.intel.com, linux-kernel@vger.kernel.org,
	kenneth.w.chen@intel.com
References: <409FFF3B.3090506@linux.intel.com> <20040511004551.7c7af44d.akpm@osdl.org> <00c001c43786$f1805000$ff0da8c0@amr.corp.intel.com> <20040511121126.73f5fdeb.akpm@osdl.org> <20040511195856.GA4958@elte.hu> <20040511131137.2390ffa8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040511131137.2390ffa8.akpm@osdl.org>; from akpm@osdl.org on Tue, May 11, 2004 at 01:11:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 01:11:37PM -0700, Andrew Morton wrote:
> +int del_single_shot_timer(struct timer_struct *timer)
> +{
> +	if (del_timer(timer))
> +		del_timer_sync(timer);
> +}

it's probably better named del_timer_singleshot given the name we gave
to the other timer functions.

