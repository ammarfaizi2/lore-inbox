Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030639AbWKUBkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030639AbWKUBkC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 20:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbWKUBkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 20:40:01 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61315 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030639AbWKUBkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 20:40:00 -0500
Date: Mon, 20 Nov 2006 17:39:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: mingo@elte.hu, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [patch] sched: decrease number of load balances
In-Reply-To: <20061120164338.B17305@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0611201734490.24998@schroedinger.engr.sgi.com>
References: <20061120142633.A17305@unix-os.sc.intel.com>
 <Pine.LNX.4.64.0611201625240.23868@schroedinger.engr.sgi.com>
 <20061120164338.B17305@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Siddha, Suresh B wrote:

> My patch is not changing any idle load balancing logic and hence it is no
> less/more aggressive as the current one.

But you cannot do anything in addition to idle balancing. You can only 
draw a process to the cpu you are balancing on. And we are already doing 
that. So this cuts down the frequency of idle balance? And only the first 
idle processor of a group of idle processors does balancing?
