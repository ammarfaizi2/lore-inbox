Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbTHJOHn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267724AbTHJOHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:07:43 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:28841 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S267186AbTHJOHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:07:41 -0400
Date: Sun, 10 Aug 2003 07:07:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: kernelbugzilla@kuntnet.org
Subject: [Bug 1068] New: Errors when loading airo module 
Message-ID: <51060000.1060524422@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1068

           Summary: Errors when loading airo module
    Kernel Version: 2.6.0-test3
            Status: NEW
          Severity: normal
             Owner: rmk@arm.linux.org.uk
         Submitter: kernelbugzilla@kuntnet.org


Distribution: Red Hat 9
Hardware Environment: Dell Inspiron 7500 P3-600.  Cisco Aironet AIR-PCM340.
Software Environment: 
Problem Description:


Steps to reproduce:

Insert card ... voila 

Aug 10 00:53:52 hordurlap cardmgr[878]: socket 1: Aironet PC4800
Aug 10 00:53:52 hordurlap cardmgr[878]: executing: 'modprobe airo_cs'
Aug 10 00:53:52 hordurlap kernel: airo:  Probing for PCI adapters
Aug 10 00:53:52 hordurlap kernel: kobject_register failed for airo (-17)
Aug 10 00:53:52 hordurlap kernel: Call Trace:
Aug 10 00:53:52 hordurlap kernel:  [<c01b9eb0>] kobject_register+0x50/0x60
Aug 10 00:53:52 hordurlap kernel:  [<c0210482>] bus_add_driver+0x52/0xb0
Aug 10 00:53:52 hordurlap kernel:  [<c021092f>] driver_register+0x2f/0x40
Aug 10 00:53:52 hordurlap kernel:  [<c018d793>] create_proc_entry+0x83/0xd0
Aug 10 00:53:52 hordurlap kernel:  [<c01c0f42>] pci_register_driver+0x72/0xa0
Aug 10 00:53:52 hordurlap kernel:  [<d08b00d3>] airo_init_module+0xd3/0xfa [airo]
Aug 10 00:53:52 hordurlap kernel:  [<c013a92c>] sys_init_module+0x12c/0x250
Aug 10 00:53:52 hordurlap kernel:  [<c010b349>] sysenter_past_esp+0x52/0x71
Aug 10 00:53:52 hordurlap kernel:
Aug 10 00:53:52 hordurlap kernel: airo:  Finished probing for PCI adapters
Aug 10 00:53:52 hordurlap kernel: airo_cs: RequestIRQ: Unsupported mode
Aug 10 00:53:53 hordurlap cardmgr[878]: get dev info on socket 1 failed:
Resource temporarily unavailable

If i then take it out and try to reinsert it, I only get RequestIRQ: Unsupported
mode.  If I then try it once again I get the oops.

