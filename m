Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTHXPGl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 11:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbTHXPGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 11:06:40 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:38537 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261162AbTHXPGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 11:06:22 -0400
Date: Sun, 24 Aug 2003 08:05:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: andrew.grover@intel.com
Subject: [Bug 1138] New: ASUS driver ignores acpi_disabled and prints message even if not used
Message-ID: <25030000.1061737552@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1138

           Summary: ASUS driver ignores acpi_disabled and prints message
                    even if not used
    Kernel Version: 2.6.0-test4
            Status: NEW
          Severity: low
             Owner: len.brown@intel.com
         Submitter: andrew.grover@intel.com


So the way things are done in the kernel, it seems that you are only expected 
to print a line (or lines) in the dmesg when your device is actually found. 
This driver prints one always.

Also, it still tries to make ACPI calls even when acpi=off. It needs to learn 
about acpi_disabled.


