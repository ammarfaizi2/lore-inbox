Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131704AbRCTD0r>; Mon, 19 Mar 2001 22:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131705AbRCTD0h>; Mon, 19 Mar 2001 22:26:37 -0500
Received: from tallinn.sydamekirurgia.ee ([193.40.6.9]:1553 "EHLO
	ns.linking.ee") by vger.kernel.org with ESMTP id <S131704AbRCTD0a>;
	Mon, 19 Mar 2001 22:26:30 -0500
Date: Tue, 20 Mar 2001 05:55:30 +0200 (EET)
From: Elmer Joandi <elmer@linking.ee>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: atyfb,matrox hardlocks, multihead, USB broken, 2.4.2-ac8
In-Reply-To: <3AB695DE.84A933D@vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0103200541050.1535-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Got it to work somewhat...
that was real long f***

the only sequence -
no dga,
kernel boots and BIOS uses Matrox PCI as first graphics
via matrox
start up two ATI cards(one AGP, one PCI)(xinerama mode,
screwed output ) with Xserver hacked to read /dev/input/event*
ant talking direct to ATI.

now insert matroxfb_base
now start two normal XFree86 on  framebuffer /dev/fb0 and /dev/fb1,
i.e. matroxes, xinerama keyboard from system console...

log into matroxes
ATI dualscreen picture clears itself by magic spell and becomes usable.

everything works... until ATI exits, then there is kernel hardlock.

Weird that all locks are hardlocks - no ping no sysreq...

SMP here.

ah - message from matrox framebuffer  - complaining no irq A assigned to
slot, and  suggesting that BIOS is buggy.


Will I be more happy when using a dualhead matrox AGP instead of AGP+PCI
ATI pair ?

2.4.0 kernel, 2.4.2-ac8 USB looks like very very broken.

elmer.



