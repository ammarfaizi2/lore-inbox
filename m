Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVJ2Ul5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVJ2Ul5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVJ2Ul5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:41:57 -0400
Received: from c-24-14-93-109.hsd1.il.comcast.net ([24.14.93.109]:14277 "EHLO
	topaz") by vger.kernel.org with ESMTP id S932065AbVJ2Ulw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:41:52 -0400
From: Narayan Desai <desai@mcs.anl.gov>
To: linux-kernel@vger.kernel.org
Subject: acpi problem on 2.6.14-rc5-mm1
Date: Sat, 29 Oct 2005 15:41:46 -0500
Message-ID: <87mzksukc5.fsf@topaz.mcs.anl.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been encountering a problem for a little while (since rc3 at
least) where acpi goes out to lunch with respect to battery
information. This works properly for a while, but then the following
kernel errors appear:
Oct 28 22:01:50 topaz kernel: [17298549.952000]     ACPI-0292: *** Error: Looking up [SERN] in namespace, AE_ALREADY_EXISTS
Oct 28 22:01:50 topaz kernel: [17298549.952000]     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.GBIF] (Node c18f6540), AE_ALREADY_EXISTS
Oct 28 22:01:50 topaz kernel: [17298549.980000]     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Oct 28 22:01:50 topaz kernel: [17298549.980000]     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._BIF] (Node c18f6280), AE_AML_METHOD_LIMIT
Oct 28 22:01:52 topaz kernel: [17298551.972000]     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Oct 28 22:01:52 topaz kernel: [17298551.972000]     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f6400), AE_AML_METHOD_LIMIT
Oct 28 22:01:52 topaz kernel: [17298551.972000]     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Oct 28 22:01:52 topaz kernel: [17298551.972000]     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._BIF] (Node c18f6280), AE_AML_METHOD_LIMIT
Oct 28 22:01:54 topaz kernel: [17298553.980000]     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Oct 28 22:01:54 topaz kernel: [17298553.980000]     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f6400), AE_AML_METHOD_LIMIT
Oct 28 22:01:54 topaz kernel: [17298553.980000]     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Oct 28 22:01:54 topaz kernel: [17298553.980000]     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._BIF] (Node c18f6280), AE_AML_METHOD_LIMIT
Oct 28 22:01:56 topaz kernel: [17298555.988000]     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Oct 28 22:01:56 topaz kernel: [17298555.988000]     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f6400), AE_AML_METHOD_LIMIT
Oct 28 22:01:56 topaz kernel: [17298555.988000]     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Oct 28 22:01:56 topaz kernel: [17298555.988000]     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._BIF] (Node c18f6280), AE_AML_METHOD_LIMIT
Oct 28 22:01:58 topaz kernel: [17298557.996000]     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Oct 28 22:01:58 topaz kernel: [17298557.996000]     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f6400), AE_AML_METHOD_LIMIT
Oct 28 22:01:58 topaz kernel: [17298557.996000]     ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
Oct 28 22:01:58 topaz kernel: [17298557.996000]     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._BIF] (Node c18f6280), AE_AML_METHOD_LIMIT

These continue to occur, every two seconds, until the machine is
rebooted. After this error happens, all acpi battery information
disappears. 

topaz# cat /proc/acpi/battery/BAT0/info 
present:                 yes
ERROR: Unable to read battery information

The hardware in question is a thinkpad t41p. It has two
batteries. Please let me know if I can provide any more
information. Does anyone have any suggestions?
 -nld
