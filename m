Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264850AbSKENK6>; Tue, 5 Nov 2002 08:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264855AbSKENK6>; Tue, 5 Nov 2002 08:10:58 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:6638 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264850AbSKENK4>; Tue, 5 Nov 2002 08:10:56 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 5 Nov 2002 05:17:10 -0800
Message-Id: <200211051317.FAA26655@adam.yggdrasil.com>
To: ink@jurassic.park.msu.ru
Subject: Re: Patch: 2.5.45 PCI Fixups for PCI HotPlug
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, jgarzik@pobox.com,
       jung-ik.lee@intel.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
>On Mon, Nov 04, 2002 at 12:29:37PM -0800, Adam J. Richter wrote:
>You cannot mark individual quirk routines differently as long as they
>belong in the same quirk list. If the list is __devinitdata and some
>of routines in it are __init, you'll have an oops in the hotplug path.

	If pci_do_fixups determines that f->vendor and f->device do
not match the device in question, it will not call the corresponding
f->hook, so it is OK for that f->hook to point to the address of a
discarded __init routine that now contains garbage as long as the
ID's will not match any hot plugged device.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

