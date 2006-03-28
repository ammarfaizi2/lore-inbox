Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWC1NyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWC1NyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWC1NyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:54:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45700 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932218AbWC1NyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:54:09 -0500
Date: Tue, 28 Mar 2006 15:23:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Random GCC segfaults -- Was: [2.6.16] slab error in slab_destroy_objs(): cache `radix_tree_node'...
Message-ID: <20060328132346.GB3300@elf.ucw.cz>
References: <20060326215346.1b303010@localhost> <20060328095521.52ea3424@localhost> <20060328004137.607e51db.akpm@osdl.org> <20060328112241.40b9c975@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328112241.40b9c975@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Tue, 28 Mar 2006 00:41:37 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > If those errors had no corresponding kernel messages then what you have is
> > a classic symptom of failing memory hardware.  Suggest you grab memtest86,
> > run it for 24 hours.
> 
> I've already run memtest86+ for hours (not 24 ok... "only" 4/5h) and I
> found this:
> 
> An easly reproducilble memory failure (single bit flipping always at
> the same address) <---- this one goes AWAY disabling bank interleaving
> in BIOS.
> 
> Another memory failure (different address, always one bit flipping)
> isn't found by memtest86+: I found it with CONFIG_DEBUG_SLAB and
> I "fixed" it with memmap=... boot option.
> 
> 
> Now, these 2 problems are both in my first 256MB memory module, so maybe
> it is really another memory failure.
> 
> BUT now that I'm back on 2.6.15.6 I'm compiling a LOT of big CPP
> projects and I haven't seen a single GCC segfault yet.
> 
> Maybe I should retry with 2.6.16 and if I can reproduce the problem I
> can start testing 2.6.16-rc1 and so on...

I'd really get new RAM... If the machine is "known bad", debugging on
it is likely waste of time.
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
