Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUGDUHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUGDUHt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 16:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUGDUHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 16:07:49 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:42990 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265768AbUGDUHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 16:07:47 -0400
Message-ID: <a728f9f904070413077d6a2966@mail.gmail.com>
Date: Sun, 4 Jul 2004 16:07:14 -0400
From: Alex Deucher <alexdeucher@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Weird problems on ibm thinkpad x24 with 2.6.5-1.358 kernel, FC2
Cc: acpi-devel@lists.sf.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently did a fresh install of fedora core 2 on my thinkpad x24. 
It had previously been running redhat 9 just fine.  For the most part,
the new 2.6 kernel is awesome.  battery power is significantly
improved and all devices and pc cards I have work fine.  The problem
is that, occasionally, more often on battery power, but also on AC,
the hard drive will start grinding away and the computer will get
slower and slower until it becomes unuseable and I have to power it
off.  Also, once or twice, my X session disappeared and it looked like
I had been switched to a console, however the font was different
(looked more like a graphical console than vga) and error messages of
some sort were being printed.  I was able to get it back to my X
session, but I don't recall how off hand.  I also don't remember what
the error message said and I haven't been able to reproduce it again. 
I suspect it may be acpi related.

dmesg:
http://www.botchco.com/alex/x24/dmesg.txt

when ACPI loads there seems to be a problem with the ECDT:

ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Found ECDT
ACPI: Could not use ECDT
    ACPI-1133: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__._INI] (Node 11eb5a9c), AE_NOT_EXIST
ACPI: Interpreter enabled

I found this page:
http://www.poupinou.org/acpi/ibm_ecdt.html
regarding broken ECDT tables on thinkpads, but it seems pretty old. 
Is this something I should do, or is there already a fix for this in
the acpi code?

contents of /proc/acpi:
http://www.botchco.com/alex/x24/proc-acpi.txt


Any advice would be much appreciated.  let me know if you need any
other information.

Thanks,

Alex
