Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVGCRme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVGCRme (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 13:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVGCRme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 13:42:34 -0400
Received: from ozlabs.org ([203.10.76.45]:53961 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261480AbVGCRmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 13:42:32 -0400
Date: Mon, 4 Jul 2005 03:38:37 +1000
From: Anton Blanchard <anton@samba.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quieten OOM killer noise
Message-ID: <20050703173837.GB15055@krispykreme>
References: <20050723150209.GA15055@krispykreme> <Pine.LNX.4.10.10507031021410.5964-100000@godzilla.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10507031021410.5964-100000@godzilla.mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Why not just remove the printk's when DEBUG_KERNEL is off. The problem
> that I've found is that the latency in the system sky rockets when OOM
> triggers. It's due to the excessive printk usage. 
> 
> I'm sure it's not ifdef'ed for a reason , but it would be nice to have an
> easy way to silence it.

We've had customer situations where that information would have been
very useful. Also DEBUG_KERNEL is enabled on some distros so it wouldnt
help there.

Id suggest adding a printk level to the printks in mm/oom-kill.c and
using /proc/sys/kernel/printk to silence them.

Anton
