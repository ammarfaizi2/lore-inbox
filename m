Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTIJIYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264831AbTIJIYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:24:45 -0400
Received: from waste.org ([209.173.204.2]:48314 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264762AbTIJIYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:24:43 -0400
Date: Wed, 10 Sep 2003 03:24:35 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/3] netpoll: netconsole
Message-ID: <20030910082435.GG4489@waste.org>
References: <20030910074256.GD4489@waste.org.suse.lists.linux.kernel> <p73znhdhxkx.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73znhdhxkx.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 10:11:42AM +0200, Andi Kleen wrote:
> Matt Mackall <mpm@selenic.com> writes:
> 
> > This patch uses the netpoll API to transmit kernel printks over UDP
> > for uses similar to serial console.
> 
> One common problem I saw with the original netconsole patches
> was that the low level drivers' poll function was grabbing the 
> driver spinlock, but the driver would otherwere do printk
> with the spinlock hold (->easy deadlock) 
> 
> Does your patchkit handle that?

No, haven't encountered it. Which lock are we talking about, specifically?

> P.S.: Also what would be really nice for netconsole
> would be "kernel ifconfig" similar to what the nfsroot code does. 
> With that it would be actually possible to use it as a full console 
> replacement.

It ups the interface if necessary and has enough info to build a
complete raw packet so if I understand you correctly, it's already
there. I start getting netconsole messages immediately after
driver/net initcalls.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
