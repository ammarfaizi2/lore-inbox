Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbTBVJKF>; Sat, 22 Feb 2003 04:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267860AbTBVJKF>; Sat, 22 Feb 2003 04:10:05 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2830 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S267859AbTBVJKF>;
	Sat, 22 Feb 2003 04:10:05 -0500
Date: Sat, 22 Feb 2003 10:06:04 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ion Badulescu <ionut@badula.org>
Cc: Mikael Pettersson <mikpe@user.it.uu.se>, m.c.p@wolk-project.de,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: UP local APIC is deadly on SMP Athlon
Message-ID: <20030222090604.GC5411@alpha.home.local>
References: <200302220038.h1M0cn6r004153@harpo.it.uu.se> <Pine.LNX.4.44.0302220144530.18311-100000@moisil.badula.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302220144530.18311-100000@moisil.badula.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Good catch, Ion !

On Sat, Feb 22, 2003 at 03:05:37AM -0500, Ion Badulescu wrote:
> As a matter of fact, I got very interesting numbers from that printk() I
> added:
> 
> - all the Intel and single proc AMD printed "0".
> - all the dual AMD machines printed "1".

Same here, dual AMD/760MPX.

BTW, there's something I don't understand. The only reference to
APIC_init_uniprocessor() I found was in smpboot.c:1044. It's called when the
SMP config has not been found at boot time (and it also sets
phys_cpu_present_map to 1, BTW). My problem is that this function is executed
on my dual-k7, on an SMP kernel (because I see the added message), but I
don't see the "SMP motherboard not detected" message which should be displayed
just before APIC_init_uniprocessor().

So I suspect there's something strange in this code that might explain why
only CPU0 receives the interrupts, but I don't understand the code path !

I'd appreciate it if someone has a clue... I can provide .config and dmesg
if needed. By this time, I'll add printk's everywhere in the kernel.

Cheers,
Willy

