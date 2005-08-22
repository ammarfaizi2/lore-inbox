Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVHVUdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVHVUdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVHVUdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:33:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44227 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751069AbVHVUdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:33:15 -0400
Date: Mon, 22 Aug 2005 13:33:06 -0700
From: Jason Uhlenkott <jasonuhl@sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: tony.luck@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK_TIME woes
Message-ID: <20050822203306.GA897956@dragonfly.engr.sgi.com>
References: <20050821021322.3986dd4a.akpm@osdl.org> <20050821021616.6bbf2a14.akpm@osdl.org> <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com> <20050822.132052.65406121.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822.132052.65406121.davem@davemloft.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 01:20:52PM -0700, David S. Miller wrote:
> From: tony.luck@intel.com
> Date: Mon, 22 Aug 2005 10:42:22 -0700
> 
> > At the other extreme ... the current use of sched_clock() with
> > potentially nano-second resolution is way over the top.
> 
> Not really, when I'm debugging TCP events over gigabit
> these timestamps are exceptionally handy.

Yes, but how many of those figures are really significant?  I strongly
suspect that the overhead of printk() is high enough, even when we're
just spewing to the dmesg buffer and not the console, that we have a
lot more precision than accuracy at nanosecond resolution.
