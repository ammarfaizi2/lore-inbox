Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbQKQWqQ>; Fri, 17 Nov 2000 17:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129411AbQKQWp5>; Fri, 17 Nov 2000 17:45:57 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:45983 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129309AbQKQWpv>; Fri, 17 Nov 2000 17:45:51 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 17 Nov 2000 14:15:03 -0800
Message-Id: <200011172215.OAA06687@adam.yggdrasil.com>
To: davem@redhat.com, jgarzik@mandrakesoft.com
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
Cc: linux-kernel@vger.kernel.org, willy@meta-x.org, wtarreau@yahoo.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:

>Are you aware of any hotplug sunhme hardware?  If no, don't change it to
>__devinit...

	Can I have a hot plug PCI bridge card that connects to
a regular PCI backplane (perhaps as some kind of CardBus docking
station card)?  If so, all PCI drivers should use __dev{init,exit}{,data}.

	The other excellent points that you raise apply equally to
the driver before and after my patch (although my patch made it
more clear that the struct netdevice parameters previously being
passed around were always null).  It is important to realize this
becase, as of yesterday, Dave had said that he was not going to
apply the new style PCI changes at this point, but had integrated
the MODULE_DEVICE_TABLE changes.  So, Dave: you should look at
the points that Jeff raised, even if you are not integrating
the rest of my new style PCI patch.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
