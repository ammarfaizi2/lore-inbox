Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbTEANkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 09:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbTEANkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 09:40:08 -0400
Received: from 12-250-182-80.client.attbi.com ([12.250.182.80]:22023 "EHLO
	sonny.eddelbuettel.com") by vger.kernel.org with ESMTP
	id S261256AbTEANkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 09:40:05 -0400
Date: Thu, 1 May 2003 08:52:28 -0500
From: Dirk Eddelbuettel <edd@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Tyan 2466 SMP locks hard with 2.4.20 + heavy disk i/o yet runs 2.2.* without problems
Message-ID: <20030501135228.GA19643@sonny.eddelbuettel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


System:
  Tyan 2466 MPX board, 2 Athlon 1800MP, bios 1.01 from March 2002
  1 gb ram, ibm + maxtor ide disks, ide cdrom + cdrw 
  ati rage 128, sb pci 128, on-board 3c905 nic
  no other cards
  hardware configuration unaltered since June of last year

Performance under 2.2.20 with ext3 + win4lin patches
  + Flawless
  + Uptime of _over 200 days_ with fairly heavy use until UPS got tripped
  + Can run bonnie++ with no issues other than very noticeable i/o slowdown

Performance under 2.4.20 with ext3 + win4lin patch
  - "Stable" until disk-heavy operation causes freeze, typically within 
    two to three days
  - Heavy disk use (full backup writing, diff against big tarball, bonnie++) 
    freeze the machine hard, no ping, no sign of live
  + memtest86 shows no problem with the ram

I searched via google and google groups, but found no pertinent idea for my
case:  No raid or scsi controller, memory doesn't seem to be an issue as it
works really, really well under 2.2.20 and memtest86 passes too. The system 
is generally very stable under 2.2.20 --- but gets killed by 2.4.20.

I run fairly stock kernels (from Debian kernel source packages) with the 
win4lin patches, and the ext3 patch in the case of 2.2.20.  ACPI is disabled.
Disk access is not tuned in any way, DMA gets enabled by default.

I would be happy to try out suggestions in terms of different kernel
configurations, or patches.  I would prefer to stay with the 2.4.* kernel for
now.

Thanks in advance for any pointers. CCs are welcome.

Dirk

-- 
Don't drink and derive. Alcohol and algebra don't mix.
