Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUHAHeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUHAHeI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 03:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUHAHeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 03:34:08 -0400
Received: from ozlabs.org ([203.10.76.45]:22721 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265398AbUHAHeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 03:34:04 -0400
Date: Sun, 1 Aug 2004 17:27:11 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use for_each_cpu
Message-ID: <20040801072711.GJ30253@krispykreme>
References: <20040801060144.GI30253@krispykreme> <20040731230859.138ba584.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731230859.138ba584.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The per cpu schedule counters need to be summed up over all possible cpus.
> >  When testing hotplug cpu remove I saw the sum of the online cpu count
> >  for nr_uninterruptible go negative which made the load average go nuts.
> 
> I think the preferred approach here is to transfer the count over to the
> current CPU in the CPU_DEAD handler.

They only look to be called out of proc, and once every 5 seconds for
loadaverage calculations. Is it worth adding complexity to the cpu
notifiers vs just using for_each_cpu?

Anton
