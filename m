Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVKUWeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVKUWeA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVKUWeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:34:00 -0500
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:31968 "EHLO
	sade.emperorlinux.com") by vger.kernel.org with ESMTP
	id S1751138AbVKUWd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:33:59 -0500
Message-ID: <43824A6F.6070407@emperorlinux.com>
Date: Mon, 21 Nov 2005 17:30:07 -0500
From: Josh Litherland <josh@emperorlinux.com>
Organization: EmperorLinux, Inc
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: research@emperorlinux.com
Subject: SATA ICH6M problems on Sharp M4000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to get this laptop operational; it has SATA for the hard disc and
PATA for the optical drive.  The hard drive is wired to the secondary
IDE interface, the optical to the primary.  As it stands, driving the
whole system with the PATA (piix) driver works, but performance for the
hard disc is (predictably) extremely poor.  With ata_piix driving the
hard drive, performance is great, but the optical device is never
enumerated.  When the piix driver tries to load, the following occurs:

ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe

We have tried to resolve this through a wide variety of kernel command
line options.  Tried every combination we could think of of ide0=0x1f0,
ide1=0x170, ide0=noprobe, ide1=noprobe, acpi=off, noapic, lapic,
pci=routeirq.  Tried shaking up module load order and using ide-generic
instead of piix.  ahci won't bind to the device; throws error -12.

Some information about this system including dmesg and lspci:

http://downloads.emperorlinux.com/research/lkml/sharp_m4000/

Thanks in advance for any advice you can give.

-- 
Josh Litherland (josh@emperorlinux.com)
Emperor Linux, Inc.
