Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTJAP0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTJAP0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:26:37 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:46821 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262369AbTJAPZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:25:40 -0400
Date: Wed, 01 Oct 2003 08:24:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: bardok@telefonica.net
Subject: [Bug 1304] New: Computer blocks when initializing ALI	Chipset on startup
Message-ID: <5990000.1065021879@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1304

           Summary: Computer blocks when initializing ALI Chipset on startup
    Kernel Version: 2.6.0-test5
            Status: NEW
          Severity: high
             Owner: greg@kroah.com
         Submitter: bardok@telefonica.net


Distribution: Debian Woody 3.0
Hardware Environment: ALI M1563 based P4 Laptop PC
Software Environment: Startup
Problem Description:

When the system tries to initialize the ALI chipset, either as a module or
compiled into the kernel, it completely hangs.

When it is compiled as a module, it just blocks the computer, but when compiled
into the kernel, it prints following error:

Unable to handle kernel NULL pointer derreference at virtual address 00000020
printing EIP:
c03f6b90
*pde = 00000000
Ooops: 0000 [#1]
...
EIP is at init_chipset_ali15x3+0x120/0x190
...
Call trace:
[...] do_ide_setup_pci_device+0x93/0x13c
[...] ide_setup_pci_device+0x1a/0x68
...

The same driver can perfectly be loaded with the 2.4.22 kernel, I even get DMA
activated...

If the maintainer needs any other help, I have no problem to hack the driver and
make any tests or researches needed, in the case he/she has no access to the
hardware this bug refers to...

Steps to reproduce:

Compile ALI15X3 into the kernel, or as a module, and reboot...


