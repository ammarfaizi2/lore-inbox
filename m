Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTKESeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTKESeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:34:18 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17032 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263082AbTKESeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:34:17 -0500
Date: Wed, 05 Nov 2003 10:34:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1493] New: Problem with airo_cs module when inserting the card
Message-ID: <105030000.1068057249@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1493

           Summary: Problem with airo_cs module when inserting the card
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: normal
             Owner: rmk@arm.linux.org.uk
         Submitter: daniel.gary@voila.fr


Distribution: Mandrake 9.0
Hardware Environment: Siemens E series Lifebook with AIR-PCM350
Software Environment:
gcc 3.2.2
cardmgr version 3.2.5

Problem Description:
When I insert the card, I receive this kernel trace :

Nov  5 18:58:57 dga kernel: airo:  Probing for PCI adapters
Nov  5 18:58:57 dga kernel: kobject_register failed for airo (-17)
Nov  5 18:58:57 dga kernel: Call Trace:
Nov  5 18:58:57 dga kernel:  [kobject_register+80/96] kobject_register+0x50/0x60
Nov  5 18:58:57 dga kernel:  [bus_add_driver+76/176] bus_add_driver+0x4c/0xb0
Nov  5 18:58:57 dga kernel:  [driver_register+49/64] driver_register+0x31/0x40
Nov  5 18:58:57 dga kernel:  [pci_register_driver+91/128]
pci_register_driver+0x5b/0x80
Nov  5 18:58:57 dga kernel:  [_end+273611698/1069468380]
airo_init_module+0xd6/0xfe [airo]
Nov  5 18:58:57 dga kernel:  [sys_init_module+292/592] sys_init_module+0x124/0x250
Nov  5 18:58:57 dga kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov  5 18:58:57 dga kernel:
Nov  5 18:58:57 dga kernel: airo:  Finished probing for PCI adapters
Nov  5 18:58:57 dga kernel: airo: MAC enabled eth1 0:d:bd:9a:35:38
Nov  5 18:58:57 dga kernel: eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 5, io
0x0100-0x01

I am a kernel newbie so this king of trace don't help me
to solve my problem.

What I am sure is that the card is not working.

Steps to reproduce:
With my configuration, I have to insert the card to receive
this trace.

