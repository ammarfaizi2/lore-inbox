Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUCYW3G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263677AbUCYW3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:29:06 -0500
Received: from gprs214-160.eurotel.cz ([160.218.214.160]:17537 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263679AbUCYW2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:28:01 -0500
Date: Thu, 25 Mar 2004 23:27:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Message-ID: <20040325222745.GE2179@elf.ucw.cz>
References: <20040323233228.GK364@elf.ucw.cz> <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz> <200403250857.08920.matthias.wieser@hiasl.net> <1080247142.6679.3.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080247142.6679.3.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> By the way, here's an example where having the /proc interface is a good
> thing: which do you use? zip compression, lzf compression or no
> compression? Until recently I always used lzf compression. I just

We should select one, and drop the others.

gzip is useless for almost everyone -> gets little testing -> is
probably broken.

> upgraded my laptop's hard drive, and found I wasn't getting the
> performance improvements in suspending I expected. It turns out that the
> CPU is now the limiting factor. Because I had the /proc interface, I
> could easily adjust the debug settings to show me throughput and then
> try a couple of suspend cycles with compression enabled and with it
> disabled. Without the /proc interface, I would have had to have
> recompiled the kernel to switch settings. (I didn't try gzip because I
> knew it wasn't going to be a contender for me).

Kernel could automagically select the right one.. But I'd prefer for
only "non compressed" part to reach mainline for 2.6. Feature freeze
was few months ago, and "adding possibility to compress swsusp data"
does not sound like a bugfix to me...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
