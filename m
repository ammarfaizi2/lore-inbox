Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVDZOyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVDZOyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVDZOyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:54:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:29394 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261491AbVDZOxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:53:53 -0400
Date: Tue, 26 Apr 2005 16:53:51 +0200
From: Andi Kleen <ak@suse.de>
To: Patrick McHardy <kaber@trash.net>
Cc: Andi Kleen <ak@suse.de>, Ed Tomlinson <tomlins@cam.org>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
Message-ID: <20050426145351.GD13305@wotan.suse.de>
References: <1114332119.916.1.camel@localhost.localdomain> <200504240903.31377.tomlins@cam.org> <426CADF1.2000100@trash.net> <20050425153541.GC16828@wotan.suse.de> <426E3C6F.6010001@trash.net> <20050426135312.GI5098@wotan.suse.de> <426E48C0.9090503@trash.net> <426E4DD2.8060808@trash.net> <20050426142252.GJ5098@wotan.suse.de> <426E5571.8000101@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426E5571.8000101@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 04:51:29PM +0200, Patrick McHardy wrote:
> Andi Kleen wrote:
> >Hmm actually - on some systems I broke the NMI watchdog. Can you
> >check your dmesg to see if check_nmi_watchdog doesnt report it 
> >as stuck? If yes please put a return on top of check_nmi_watchdog
> >that should fix it. You can verify it works by looking at the
> >per CPU NMI counters in /proc/interrupts. An nmi watchdog
> >backtrace would be nice to see.
> 
> No occurences of check_nmi_watchdog in dmesg or my logs, just
> "Using local APIC NMI watchdog using perfctr0". /proc/interrupts
> shows:
> 
> NMI:        181

It is Checking NMI watchdog .... if you see "stuck" after that it is
broken. Or do the NMIs actually increase when you make the machine
busy (run while true ; do true ; done on each CPU)?

-Andi
