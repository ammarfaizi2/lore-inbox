Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSKDSQx>; Mon, 4 Nov 2002 13:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSKDSQw>; Mon, 4 Nov 2002 13:16:52 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:17579 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262604AbSKDSQw>; Mon, 4 Nov 2002 13:16:52 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 4 Nov 2002 10:23:20 -0800
Message-Id: <200211041823.KAA09629@adam.yggdrasil.com>
To: jung-ik.lee@intel.com
Subject: RE: Patch: 2.5.45 PCI Fixups for PCI HotPlug
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Greg KH wrote:
>> >Hm, in looking at this, I know the majority of people who want
>> >CONFIG_HOTPLUG probably do not run with CONFIG_PCI_HOTPLUG as the
>> >hardware's still quite rare.  To force those people to keep 
>> around all
>> >of the PCI quirks functions and tables after init happens, is a bit
>> >cruel.  I wonder if it's time to start having different subsystems
>> >modify __devinit depending on their config variables.
>> 
>> 	Are there PCI bridge cards that use all of those?  For
>> example, I thought that Triton was a series of Intel motherboard
>> chipsets for 586 processors.  Perhaps you only need to keep a
>> few of those routines.
>> 
>> 	Jung-Ik: perhaps you could to an lspci and an "lspci -n" on
>> your machine when the bridge card is plugged in, which should provide
>> enough information to determine which routines you really need to
>> keep.

>That sounds a quick fix for now but Greg's __pci_devinit seems to be the
>right solution.

	There is no reason to use __pci_devinit for chipsets that are
only soldered into motherboards.  I believe there are only a few of
those quirk handlers that CONFIG_PCI_HOTPLUG users really need to
retain in their kernels.

	I would appreciate it if you would do the lspci commands I requested
or just send the contents of your /proc/bus/pci/devices file.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."



