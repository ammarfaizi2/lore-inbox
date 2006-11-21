Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030577AbWKUAjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030577AbWKUAjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966892AbWKUAjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:39:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:7589 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S965978AbWKUAjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:39:24 -0500
Date: Mon, 20 Nov 2006 16:39:03 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: mingo@elte.hu, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [patch] sched: decrease number of load balances
In-Reply-To: <20061120142633.A17305@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0611201625240.23868@schroedinger.engr.sgi.com>
References: <20061120142633.A17305@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Siddha, Suresh B wrote:

> +		if (local_group && balance_cpu != this_cpu && balance) {
								^^^^^

This would need to be *balance right? balance is always != 0.

> +			*balance = 0;
> +			goto ret;
> +		}

How well was this patch tested?

We already have idle processors pulling processes from elsewhere in the 
system. Load balancing on an idle processor could only replicate the 
balance on idle logic.


