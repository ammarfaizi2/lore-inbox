Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSKJARb>; Sat, 9 Nov 2002 19:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262825AbSKJARb>; Sat, 9 Nov 2002 19:17:31 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:44458 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262824AbSKJARa>; Sat, 9 Nov 2002 19:17:30 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 9 Nov 2002 16:23:59 -0800
Message-Id: <200211100023.QAA27139@baldur.yggdrasil.com>
To: James.Bottomley@steeleye.com
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
Cc: andmike@us.ibm.com, greg@kroah.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org, willy@debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
>3. Machine is partially consistent.  consistent allocation may fail because 
>we're out of consistent memory so we have to fall back to the old.

	I'd like to know more about what these machines look
like in the real world.  Specifically, I am interested in the
trade-off of having a parameter to wback_fake_consistent
so that it could be enabled or disabled on an individual basis.

	I suspect that the parameter is not worth the clutter because
these "partially consistent" machines either have a large amount of
consistent memory, so the case of the allocation failing in the is not
worth supporting, or it is easy to check for consistent memory on them
with something like "if ((unsigned long) vaddr < 0xwhatever)", but I'm
just guessing.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


