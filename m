Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290930AbSBLKUK>; Tue, 12 Feb 2002 05:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290953AbSBLKUB>; Tue, 12 Feb 2002 05:20:01 -0500
Received: from grisu.bik-gmbh.de ([194.233.237.82]:36882 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP
	id <S290930AbSBLKTn>; Tue, 12 Feb 2002 05:19:43 -0500
Date: Tue, 12 Feb 2002 11:20:05 +0100
From: Florian Hars <florian@hars.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Unknown Southbridge (was: Disk-I/O and kupdated@99.9% system (2.4.18-pre9))
Message-ID: <20020212102005.GB365@bik-gmbh.de>
In-Reply-To: <20020208164250.GA321@bik-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208164250.GA321@bik-gmbh.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Whenever I do some heavy disk-I/O (like untaring an archive with 13000
> files that amount to 5GB), the CPU-state repeatedly goes to 99.9%
> system

Part of the problem could be alleviated by unmasking the interrupts,
but now some part of the IDE system is crying for its master:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: Unknown VIA SouthBridge, contact Vojtech Pavlik <vojtech@suse.cz>

I use a Gigabyte GA-7VTXE with a VIA KT266A chipset and a Southbridge
called VT8233A, which does not look like one of the "FUTURE_BRIDGES"
that are ifdefed out in the driver (or is it the same as the
{ "vt8233c",    PCI_DEVICE_ID_VIA_8233C,    0x00, 0x2f, VIA_UDMA_100 } ?).

Yours, Florian Hars.
