Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKSIYl>; Sun, 19 Nov 2000 03:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132084AbQKSIYa>; Sun, 19 Nov 2000 03:24:30 -0500
Received: from [209.249.10.20] ([209.249.10.20]:39085 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129152AbQKSIYT>; Sun, 19 Nov 2000 03:24:19 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 18 Nov 2000 23:54:18 -0800
Message-Id: <200011190754.XAA09012@adam.yggdrasil.com>
To: acahalan@cs.uml.edu
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan <acahalan@cs.uml.edu> writes:
>PCI is certainly hot-plug hardware, but not on common desktop PCs.
>Since PCI is so popular and so often not hot-plug, users should
>not be forced to have hot-plug PCI support when they only need
>hot-plug SCSI, etc.

>Obvious hack:  __pciinit, __pciexit, __pciinitdata...

	Yes, as I mentioned in a previous discussion, sometime after
2.4.0, I would like to see CONFIG_HOTPLUG replaced with CONFIG_PCI_HOTPLUG
with __pci{init,exit}{,data}, and CONFIG_USB_HOTPLUG with
__usb{init,exit}{,data} and likewise for other busses, since these
facilities are completely independent, and there are reasons for
wanting to compile in one facility compiled in and not the others,
and it would make drivers self-document which hotplug facility
is the reason why something should be marked as __dev{init,exit}{,data}.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
