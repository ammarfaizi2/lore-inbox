Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbULDSda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbULDSda (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 13:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbULDSda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 13:33:30 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:50560
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262567AbULDSd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 13:33:26 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Voluspa <lista4@comhem.se>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041204164353.GE32635@dualathlon.random>
References: <200412041242.iB4CgsN07246@d1o408.telia.com>
	 <20041204164353.GE32635@dualathlon.random>
Content-Type: text/plain
Date: Sat, 04 Dec 2004 19:33:24 +0100
Message-Id: <1102185205.13353.309.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-04 at 17:43 +0100, Andrea Arcangeli wrote:
> On Sat, Dec 04, 2004 at 01:42:54PM +0100, Voluspa wrote:
>
> If try_to_free_pages is being recalled during boot them we've a problem
> somewhere else, it should never happen!
> 
> Plus it works like a charm here.
> 
> Can you send me your .config so that I will try to send you privately a
> kernel image built on my machine? (and before sending I'll try to boot
> it locally ;) My .config sure is happily running.
> 

You want my .config too ? :)

I tried again from scratch and the kernel is booting without your patch.
Adding your patch with the same config still does not boot. It does not
depend on PREEMPT=y/n.

I added some debug output and it calls __alloc_pages a couple of times.
All those calls get out from the first goto got_pg as expected.

I will try to add some more debug later

tglx


