Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264187AbTKJXFH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 18:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTKJXFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 18:05:07 -0500
Received: from dp.samba.org ([66.70.73.150]:24752 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264187AbTKJXFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 18:05:04 -0500
Date: Tue, 11 Nov 2003 10:00:42 +1100
From: Anton Blanchard <anton@samba.org>
To: Jack Steiner <steiner@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
Message-ID: <20031110230042.GF930@krispykreme>
References: <20031110215844.GC21632@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031110215844.GC21632@sgi.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> I also verified on a system simulator that the counter in
> note_interrupt() is the only line that is bounced between cpus at a HZ
> rate on an idle system.
> 
> The IPI & reschedule interrupts have a similar problem but at a lower
> rate.

We havent seen this on ppc64 because our timer interrupt doesnt go via
the standard interrupt path (its a separate exception). IPIs do however
so Id expect these to be a problem for us.

Anton
