Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbTEMPkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTEMPkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:40:45 -0400
Received: from franka.aracnet.com ([216.99.193.44]:49043 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261218AbTEMPkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:40:40 -0400
Date: Tue, 13 May 2003 06:39:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 710] New: Kernel freezes with ACPI enabled
Message-ID: <21890000.1052833145@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Kernel freezes with ACPI enabled
    Kernel Version: 2.5.69
            Status: NEW
          Severity: blocking
             Owner: andrew.grover@intel.com
         Submitter: hancik@atlas.cz


Distribution: Debian/GNU SID 
Hardware Environment: Acer TravelMate 432LC (P4 2.5GHz, MB Intel 845G, Ati
R7500, 256 RAM)
Software Environment: Kernel 2.5.66 with ACPI patch 2003-03-28 patch, 2.5.69
(original)
Problem Description:
After time (1-5 hours) system freezes totally. CPU Usage is 100 % (cpu fans run
quickly). In syslog I've got this errors:

May 5 15:59:49 drax kernel: psargs-0352: *** Error: Looking up [PBIF] in namespace,
AE_NOT_FOUND
May 5 15:59:49 drax kernel: psparse-1121: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.BAT1._BIF] (Node c12eb728), AE_NOT_FOUND
May 5 15:59:49 drax kernel: acpi_battery-0134 [43304] acpi_battery_get_info : Error
evaluating _BIF
May 5 16:03:24 drax kernel: exresnte-0130 [43313] ex_resolve_node_to_val: No object
attached to node c12eb728
May 5 16:03:24 drax kernel: acpi_battery-0134 [43308] acpi_battery_get_info : Error
evaluating _BIF
May 5 16:12:33 drax kernel: exresnte-0130 [43315] ex_resolve_node_to_val: No object
attached to node c12eb728
May 5 16:12:33 drax kernel: acpi_battery-0134 [43310] acpi_battery_get_info : Error
evaluating _BIF

Message is repeated till system isn't reseted.
When I boot kernel with parameter acpi=off, everythigs works fine (don't freezes
 and don't works my battery informations).

Steps to reproduce:
Simple, boot kernel and wait for freeze.


