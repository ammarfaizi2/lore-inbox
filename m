Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbTA0JWW>; Mon, 27 Jan 2003 04:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbTA0JWW>; Mon, 27 Jan 2003 04:22:22 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:24076 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265114AbTA0JWV>; Mon, 27 Jan 2003 04:22:21 -0500
Date: Mon, 27 Jan 2003 12:30:57 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Richard Henderson <rth@twiddle.net>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isa_virt_to_bus and co on Alpha
Message-ID: <20030127123057.A2569@jurassic.park.msu.ru>
References: <wrpznpnln94.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <wrpznpnln94.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Sun, Jan 26, 2003 at 08:33:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 08:33:27PM +0100, Marc Zyngier wrote:
> The following trivial patchlet (against 2.5.59) adds the missing
> isa_virt_to_bus/isa_bus_to_virt API to the Alpha architecture.

Please don't do that. virt_to_bus/bus_to_virt are deprecated since 2.2,
drivers are supposed to use DMA mapping API instead.

> This is at least needed by the aha1740 driver. With this patch, the
> ol' good Jensen is back running 2.5 ;-).

And it won't work on anything but Jensen. All other alphas have
direct map window at 1 or 2 Gb, which cannot be reached by ISA
busmaster because of 24 address wires limitation.

Ivan.
