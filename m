Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUGSTru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUGSTru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 15:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUGSTrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 15:47:49 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:51735 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S265212AbUGSTro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 15:47:44 -0400
Message-Id: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.1
X-projects-eio: lpar-ide-hotplug
To: Linux IDE Mailing List <linux-ide@vger.kernel.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] IDE/ATA/SATA controller hotplug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 Jul 2004 14:47:39 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Howdy!

  This note went out originally to a semi-internal list, but after
  several comments, posting it here...

  As we chug along here in PPC64 land, we (meaning IBM internal) have
  been given a requirement to make all devices on our new DLPAR
  (POWER5 and later) systems be hotplug capable.  This includes ALL
  PCI devices on the system, even those that are soldered on the
  motherboard.

  This raises some interesting issues when dealing with IDE devices.

  I realize there is considerable work under way (hi Bart :) to clean
  up the 2.6 trees.  This hotplug work would be another delta on top
  of that work.

  The changes could also possibly affect the libata work, as that
  could also be touched by work on the attached devices themselves.

  What I would like is input on the general strategy that should be
  taken to modify the controller/adapter and device stack to:

  1) be first class modules, where all controllers/adapters are
     capable of being loaded and unloaded.  This is directed mostly at
     IDE/Southbridge controller/adapter devices.

  2) extend that support to all child devices; disk, optical,
     and tape.

  3) be part of mainline.

  The items I perceive at the top of the issue list are:

  - The primary platforms for IDE/ATA devices are x86 based, and
    certainly do not care about having this capability.

  - Assuming the capability is added, what rework would be acceptable
    for block devices?

  - Where should this capability go?  Fork a subset of IDE
    controllers, and put them under the arch specific dir?
    Or include all devices?

  - should we work to the goal of having the capability for all
    platforms, and all IDE devices?

++doug






