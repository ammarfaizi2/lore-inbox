Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUBVCXb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbUBVCXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:23:31 -0500
Received: from dp.samba.org ([66.70.73.150]:34215 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261644AbUBVCX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:23:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Booting when CPUs fail to come up. 
In-reply-to: Your message of "Sat, 21 Feb 2004 14:33:59 BST."
             <20040221133359.GA339@elf.ucw.cz> 
Date: Sun, 22 Feb 2004 12:43:04 +1100
Message-Id: <20040222022340.E9D132C361@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040221133359.GA339@elf.ucw.cz> you write:
> Hi!
> 
> > > > I recently played with setting a bit in cpu_possible_map that wasn't
> > > > in cpu_online_map: this can happen without hotplug CPU when a CPU
> > > > fails to boot, for example.
> > > 
> > > Is it safe to continue when one cpu is apparently malfunctioning?
> > 
> > Well, patch was overzealous and no longer required.
> > 
> > But we shouldn't crash when this happens just because a CPU didn't
> > come up.
> 
> I still do not agree.

You're entitled.  However, on x86 we booted before when a secondary
CPU didn't come up, and the patch was designed to ensure that we still
did so.

> You have a system you tried to kick CPU #13 alive, and something very
> wrong happened, CPU #13 did not come up. It is there, has full access
> to memory, it is probably running some kind of program....

No, it's possible, but not online.  This actually happens on archs
where you have hotplug cpus, as well as x86 boot failures.

> I'd not dare mount disks read-write in such situation and I believe
> crashing early is actually right thing to do.

Sure, send a patch for x86 to do that, and we can discuss that.  I'm
not going to break existing behavior by stealth though.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
