Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbTA1RYm>; Tue, 28 Jan 2003 12:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbTA1RYm>; Tue, 28 Jan 2003 12:24:42 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:8452 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267435AbTA1RYk>; Tue, 28 Jan 2003 12:24:40 -0500
Date: Tue, 28 Jan 2003 20:33:09 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Martin Mares <mj@ucw.cz>,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030128203309.A939@jurassic.park.msu.ru>
References: <20030128132406.A9195@jurassic.park.msu.ru> <Pine.GSO.4.21.0301281126390.9269-100000@vervain.sonytel.be> <20030128201057.A690@jurassic.park.msu.ru> <1043774595.536.4.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1043774595.536.4.camel@zion.wanadoo.fr>; from benh@kernel.crashing.org on Tue, Jan 28, 2003 at 06:23:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 06:23:15PM +0100, Benjamin Herrenschmidt wrote:
> Ok, if I understand properly, all we have to do on PPC is to implement a
> pci_request_legacy_resource() that will do the right thing for legacy
> VGA memory as well ?

Exactly.

> Then, please, check the return value of pci_request_legacy_resource()
> for getting to the VGA memory. Some machines (typically PowerMacs)
> simply don't give you a way to generate PCI cycles to those low memory
> addresses (you can't do VGA on those).

I agree, it certainly needs to be fixed.

The reason why I didn't it is that i386 has 0xa0000-0xbfffff region already
claimed (somewhere in arch code?), I haven't looked into this yet.

Ivan.
