Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbTJTOPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbTJTOPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:15:14 -0400
Received: from hell.org.pl ([212.244.218.42]:33293 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262626AbTJTOPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:15:11 -0400
Date: Mon, 20 Oct 2003 16:15:12 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@osdl.org>
Subject: [PM][ACPI] No ACPI interrupts after resume from S1
Message-ID: <20031020141512.GA30157@hell.org.pl>
Mail-Followup-To: acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Suspending and resuming from S1 disables ACPI interrupts for my machine
(ASUS L3800C laptop). No further interrupts and events are generated,
/proc/interrupts shows no change w.r. to ACPI. This happens regardless of
whether the specific IRQ is shared or not.

Versions affected: 2.6.0-test[5-8], 2.6.0-test5-mm4, 2.6.0-test6-mm4.
Versions unaffected: 2.6.0-test3, 2.4.22 with 20030918 ACPI.

Note: it seems that running a pmdisk cycle after resume from S1 reenables
the interrupts somehow (though treat it as a not-thoroughly-tested
observation for now).

http://bugme.osdl.org/show_bug.cgi?id=1185 may contain information relevant
to the matter (DSDT, dmesg, etc.).

I'll be happy to provide any further info.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
