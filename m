Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267870AbTBVJXH>; Sat, 22 Feb 2003 04:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267871AbTBVJXG>; Sat, 22 Feb 2003 04:23:06 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:4366 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S267870AbTBVJXF>;
	Sat, 22 Feb 2003 04:23:05 -0500
Date: Sat, 22 Feb 2003 10:19:05 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Ion Badulescu <ionut@badula.org>, Mikael Pettersson <mikpe@user.it.uu.se>,
       m.c.p@wolk-project.de, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: UP local APIC is deadly on SMP Athlon
Message-ID: <20030222091905.GD5411@alpha.home.local>
References: <200302220038.h1M0cn6r004153@harpo.it.uu.se> <Pine.LNX.4.44.0302220144530.18311-100000@moisil.badula.org> <20030222090604.GC5411@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222090604.GC5411@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 10:06:04AM +0100, Willy Tarreau wrote:

> BTW, there's something I don't understand. The only reference to
> APIC_init_uniprocessor() I found was in smpboot.c:1044. It's called when the
> SMP config has not been found at boot time (and it also sets
> phys_cpu_present_map to 1, BTW). My problem is that this function is executed
> on my dual-k7, on an SMP kernel (because I see the added message), but I
> don't see the "SMP motherboard not detected" message which should be displayed
> just before APIC_init_uniprocessor().

Oops ! Sorry for the noise, I confused the message about phys_id_present_map
with the one I added to APIC_init_uniprocessor(). So I confirm that this
function is NOT executed on my dual-k7.

Cheers,
Willy

