Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751963AbWCOIzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbWCOIzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 03:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWCOIzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 03:55:51 -0500
Received: from ns1.rothwell.us ([72.236.213.43]:39552 "EHLO rothwell.us")
	by vger.kernel.org with ESMTP id S1751775AbWCOIzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 03:55:50 -0500
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Transfer-Encoding: 7bit
Message-Id: <B43A4369-3E69-4DCC-8AEF-F4D11AF82D64@rothwell.us>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Michael Rothwell <michael@rothwell.us>
Subject: bug report: Pegasus USB Ethernet driver, SNMPd, and kernel errors
Date: Wed, 15 Mar 2006 03:55:43 -0500
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a Linksys USB-Ethernet adapter (ADMtek AN986 "Pegasus") on  
a 2.6.15-1.1833_FC4 system (if this is an inappropriate place to  
report this bug, let me know, and my apologies).

I am running snmpd on that same system. A very short while after  
snmpd is started, the kernel begins to log errors related to the  
pegasus driver. It does not log these errors if snmpd is not running.  
The errors seem to be triggered by snmpd's polling of the machine's  
network interfaces. Once the errors begin, snmpd hangs in an  
unkillable state until the machine is rebooted.

Sample of errors:

Mar 13 18:43:41 kronk kernel: pegasus: v0.6.12 (2005/01/13), Pegasus/ 
Pegasus II USB Ethernet driver
Mar 13 18:43:41 kronk kernel: pegasus 1-1:1.0: eth2, ADMtek AN986  
"Pegasus" USB Ethernet (evaluation board), 00:e0:98:77:9d:ae
Mar 13 18:43:41 kronk kernel: usbcore: registered new driver pegasus
Mar 13 18:46:27 kronk kernel: pegasus 1-1:1.0: get_registers, status -22
Mar 13 18:46:27 kronk kernel: pegasus 1-1:1.0: ctrl_callback, status -71
Mar 13 18:46:57 kronk kernel: pegasus 1-1:1.0: set_register, status -22
Mar 13 18:46:57 kronk kernel: pegasus 1-1:1.0: set_registers, status -22
Mar 13 18:46:57 kronk kernel: pegasus 1-1:1.0: set_register, status -22
Mar 13 18:46:57 kronk kernel: pegasus 1-1:1.0: get_registers, status -22
Mar 13 18:46:57 kronk kernel: pegasus 1-1:1.0: set_register, status -22
Mar 13 18:46:57 kronk kernel: pegasus 1-1:1.0: get_registers, status -22
Mar 13 18:46:57 kronk kernel: pegasus 1-1:1.0: fail read_mii_word
Mar 13 18:46:57 kronk kernel: pegasus 1-1:1.0: fail read_mii_word
Mar 13 18:47:27 kronk kernel: pegasus 1-1:1.0: set_register, status -22
Mar 13 18:47:27 kronk kernel: pegasus 1-1:1.0: set_registers, status -22
Mar 13 18:47:27 kronk kernel: pegasus 1-1:1.0: set_register, status -22

I love that Linksys' shipping product uses an "evaluation board".



--
Michael Rothwell
michael at rothwell.us



