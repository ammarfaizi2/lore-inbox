Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWHHTwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWHHTwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWHHTwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:52:09 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:47628 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1030276AbWHHTwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:52:07 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Thomas Stewart" <thomas@stewarts.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Only 3.2G ram out of 4G seen in an i386 box
Date: Tue, 8 Aug 2006 12:51:54 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEDCNKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060808101504.GJ2152@stingr.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 08 Aug 2006 12:46:57 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 08 Aug 2006 12:46:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Replying to Thomas Stewart:

> > Hi,
> > I have a Dell Optiplex GX280, a Pentium 4 with an Intel chipset. It has
> > 4G of ram. The problem is I can only see 3.2G, even tho the bios reports
> > 4G.

> Chipset issue. Some Intel chipsets are doing strange things with memory
> map. They call this "design flaw" but not offered free replacements
> yet, so, for example, on SE7221BK1E you can't use more than 3 gigs.

	It is quite funny to read Intel's technical note on this, as they try to
make it seem like they're blaming the operating system. For example:

When the Intel E7221 chipset is populated to its maximum memory capacity of
4 GB (Giga Bytes), the Operating System (OS) may report a significantly
lower amount of available memory.

	Yeah, that stupid operating system.

These requirements may reduce the addressable memory space available to and
reported by the Operating System. These memory ranges, while unavailable to
the OS, are still being utilized by subsystems such as I/O, PCI Express and
Integrated Graphics and are critical to the proper functioning of the
server.

Use of Available memory below 4 GB by system resources is not specific to
Intel chipsets, but rather a limitation of existing PC architectures and
current limitations of some 32-bit operating systems. Some 32-bit operating
systems may not be capable of recognizing greater than 2 GB of memory. This
issue potentially impacts any chipset with 4GB maximum memory configuration.

Intel has addressed this from a hardware perspective in future platforms,
anticipating that future Operating Systems will provide greater than 4 GB of
memory support.

	Last but not least, their solution.

Corrective Action / Resolution
Intel Server Board SE7221BK1-E system BIOS will be updated to properly
indicate the following information screens augment memory configuration
characteristics for the Intel Server Board SE7221BK1-E and Intel Server
Platform SR1425BK1-E customers.
 Total physical memory populated in the system
 Total memory dedicated to motherboard resources
 Total memory reported as available to the operating system
This information will align to the INT15h E820h standard that BIOS uses to
communicate memory usage to the operating system. This BIOS feature will
clarify the memory subsystem support and usage for the end user.

	Are these technical notes supposed to be so funny?

	DS


