Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbTAAVnK>; Wed, 1 Jan 2003 16:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTAAVnK>; Wed, 1 Jan 2003 16:43:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60432 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265098AbTAAVnJ>; Wed, 1 Jan 2003 16:43:09 -0500
Date: Wed, 1 Jan 2003 13:46:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH,RFC] move CONFIG_NET to net/Kconfig
In-Reply-To: <20030101204325.GB17053@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0301011345100.12809-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Jan 2003, Tomas Szepe wrote:
>
> > The best part of this patch is that it eliminates a lot of duplicit
> > stuff in 15 arch-specific files (only sparc32 and m68k define their
> > net devices in an arch specific Kconfig) and places a single 'source
> > "drivers/net/Kconfig"' line in the one file where it belongs, net/Kconfig.
> 
> Of course I could move sparc32 and m68k specific net devices to
> drivers/net/Kconfig as well.

I really think that's the only reasonable option. Please talk to Davem 
about getting the resuling sparc problems fixed up (it probably entails 
making sure that all the network drivers have the proper dependencies on 
PCI and ISA etc).

		Linus

