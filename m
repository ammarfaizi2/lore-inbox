Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVGCUMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVGCUMa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 16:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVGCUMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 16:12:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55547 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261238AbVGCUM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 16:12:26 -0400
Date: Sun, 3 Jul 2005 13:12:19 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Anton Blanchard <anton@samba.org>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] quieten OOM killer noise
In-Reply-To: <20050703173837.GB15055@krispykreme>
Message-ID: <Pine.LNX.4.44.0507031307040.4517-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, Anton Blanchard wrote:

> 
> Hi,
> 
> > Why not just remove the printk's when DEBUG_KERNEL is off. The problem
> > that I've found is that the latency in the system sky rockets when OOM
> > triggers. It's due to the excessive printk usage. 
> > 
> > I'm sure it's not ifdef'ed for a reason , but it would be nice to have an
> > easy way to silence it.
> 
> We've had customer situations where that information would have been
> very useful. Also DEBUG_KERNEL is enabled on some distros so it wouldnt
> help there.
> 
> Id suggest adding a printk level to the printks in mm/oom-kill.c and
> using /proc/sys/kernel/printk to silence them.

The latency problem stems from running printk, so I'm not sure that 
silencing them in this way would help . We could add a debug option just 
for this ? I'm sure OOM has other debugging output . CONFIG_OOM, and 
CONFIG_DEBUG_OOM .

Daniel  

