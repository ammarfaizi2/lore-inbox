Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbULEPeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbULEPeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 10:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbULEPeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 10:34:10 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:59035 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261199AbULEPeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 10:34:07 -0500
Date: Sun, 5 Dec 2004 16:34:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Voluspa <lista4@comhem.se>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041205153404.GC30536@dualathlon.random>
References: <200412041242.iB4CgsN07246@d1o408.telia.com> <20041204164353.GE32635@dualathlon.random> <1102185205.13353.309.camel@tglx.tec.linutronix.de> <1102194124.13353.331.camel@tglx.tec.linutronix.de> <20041205002736.GE13244@dualathlon.random> <1102258507.13353.366.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102258507.13353.366.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2004 at 03:55:07PM +0100, Thomas Gleixner wrote:
> Yes, the modification are not interfering with your patch. They just add
> the accounting of child processes to the selection.

Could you post your modifications on top of my patch so we can combine
them easily?

> That makes sense, but it does not catch processes forking a lot of
> childs, because the allocation rate is not accounted to the parent.

Not sure, the child could easily inherit the allocation rate of the parent.
So if the fork bomb spreads the last leaf in the process tree would
easily get accounted for every kernel stack/fds/etc.. and userspace
allocation done from its previous parents too.
