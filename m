Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbUBUNeO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 08:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUBUNeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 08:34:14 -0500
Received: from gprs154-206.eurotel.cz ([160.218.154.206]:16512 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261546AbUBUNeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 08:34:13 -0500
Date: Sat, 21 Feb 2004 14:33:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Booting when CPUs fail to come up.
Message-ID: <20040221133359.GA339@elf.ucw.cz>
References: <20040220161042.GI23278@elf.ucw.cz> <20040221010811.2D3112C3A8@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221010811.2D3112C3A8@lists.samba.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I recently played with setting a bit in cpu_possible_map that wasn't
> > > in cpu_online_map: this can happen without hotplug CPU when a CPU
> > > fails to boot, for example.
> > 
> > Is it safe to continue when one cpu is apparently malfunctioning?
> 
> Well, patch was overzealous and no longer required.
> 
> But we shouldn't crash when this happens just because a CPU didn't
> come up.

I still do not agree.

You have a system you tried to kick CPU #13 alive, and something very
wrong happened, CPU #13 did not come up. It is there, has full access
to memory, it is probably running some kind of program.... I'd not
dare mount disks read-write in such situation and I believe crashing
early is actually right thing to do.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
