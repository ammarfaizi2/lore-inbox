Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbTAAVrY>; Wed, 1 Jan 2003 16:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTAAVrY>; Wed, 1 Jan 2003 16:47:24 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:18368 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265205AbTAAVrX>; Wed, 1 Jan 2003 16:47:23 -0500
Date: Wed, 1 Jan 2003 22:55:41 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH,RFC] move CONFIG_NET to net/Kconfig
Message-ID: <20030101215541.GF17053@louise.pinerecords.com>
References: <20030101204325.GB17053@louise.pinerecords.com> <Pine.LNX.4.44.0301011345100.12809-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301011345100.12809-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [torvalds@transmeta.com]
> >
> > > The best part of this patch is that it eliminates a lot of duplicit
> > > stuff in 15 arch-specific files (only sparc32 and m68k define their
> > > net devices in an arch specific Kconfig) and places a single 'source
> > > "drivers/net/Kconfig"' line in the one file where it belongs, net/Kconfig.
> > 
> > Of course I could move sparc32 and m68k specific net devices to
> > drivers/net/Kconfig as well.
> 
> I really think that's the only reasonable option. Please talk to Davem 
> about getting the resuling sparc problems fixed up (it probably entails 
> making sure that all the network drivers have the proper dependencies on 
> PCI and ISA etc).

Yes, I'm working on that at the moment.  Pete Zaitcev likes the idea and
DaveM won't probably hate it either, as that's how sparc64 has always been.

I'll carry on with this as soon as sparclinux people ack the resulting patch.
I have no clue about m68k whatsoever.

-- 
Tomas Szepe <szepe@pinerecords.com>
