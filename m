Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266982AbUBEXIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266994AbUBEXHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:07:21 -0500
Received: from www.piratehaven.org ([204.253.162.40]:38111 "EHLO
	skull.piratehaven.org") by vger.kernel.org with ESMTP
	id S267092AbUBEXEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:04:35 -0500
Date: Thu, 5 Feb 2004 15:04:34 -0800
From: Dale Harris <rodmur@maybe.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.24, ACPI, hyperthreading and strange messages
Message-ID: <20040205230434.GC27523@maybe.org>
Mail-Followup-To: Dale Harris <rodmur@maybe.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Howdie,

I'm seeing some usual messages from dmesg with a kernel that I have
running on a cluster.  I have hyperthreading capable Xeons, Supermicro
mobos, and the nodes have LinuxBIOS (but the mayor does not).  I had to
bump the CONFIG_NR_CPUS to 8 to be able to even see both CPUs on the
nodes.  The messages I see that concern me are:

[on the nodes, where hyperthreading is not activated]:

  WARNING: No sibling found for CPU 0.
  WARNING: No sibling found for CPU 1.

[next occurs on the nodes and the mayor]

  ACPI: System description tables not found
      ACPI-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
      ACPI-0134: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
  ACPI: Unable to load the System Description Tables
  PCI: Probing PCI hardware
  PCI: ACPI tables contain no PCI IRQ routing entries



So the problem occured independant of what BIOS I have, at least so it
seems.  Links full kernel config and dmesgs are below:

[a node, with linux bios, no HT]
   http://research.amnh.org/users/rodmur/dmesg.new
[the mayor, no linux bios, HT activated]
   http://research.amnh.org/users/rodmur/dmesg.dmtr
[kernel config used on all machines]
   http://research.amnh.org/users/rodmur/config.bproc


Is there a problem with the kernel or my configuration of it?


--
Dale Harris   
rodmur@maybe.org
/.-)
