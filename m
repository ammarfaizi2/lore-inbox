Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVGEEEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVGEEEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 00:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVGEED7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 00:03:59 -0400
Received: from mail.harcroschem.com ([208.188.194.242]:18189 "EHLO
	kcdc1.harcros.com") by vger.kernel.org with ESMTP id S261764AbVGEED5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 00:03:57 -0400
Message-ID: <D9A1161581BD7541BC59D143B4A06294021FAAB0@KCDC1>
From: "Hodle, Brian" <BHodle@harcroschem.com>
To: "'Sean Bruno'" <sean.bruno@dsl-only.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [WORKAROUND] For ASUS K8N-DL PCI allocation issues
Date: Mon, 4 Jul 2005 22:59:05 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean , thats what I have been doing for a few weeks now. If I disable the
ACPI APIC in the BIOS I can use the sound, network, and USB. However, if it
is enabled it locks while trying to share out IRQ 169 for the USB
Controller. (This happens even if I disable the USB Controller!). I fixed it
by removing OHCI support from the kernel.

Cheers,

-Brian

-----Original Message-----
From: Sean Bruno [mailto:sean.bruno@dsl-only.net]
Sent: Monday, July 04, 2005 4:44 PM
To: Alexander Nyberg
Cc: bcoffman@infofromdata.com; Karim Yaghmour; Peter Buckingham; Andi
Kleen; Alistair John Strachan; Hodle, Brian;
'linux-kernel@vger.kernel.org'; 'ipsoa@posiden.hopto.org'
Subject: [WORKAROUND] For ASUS K8N-DL PCI allocation issues


I have determined that if you disable ACPI altogether in the BIOS I can
actually use the on-board hardware.  There are still allocation issues,
but I can access the USB controller, Sound and Broadcom ethernet adapter
at this point.  I haven't tested any further and would like some other
K8N-DL users to test my findings and make sure that this is the only
setting required to make the board functional at this point.

With BIOS 1003, enter the BIOS and move to POWER.  Set ACPI APIC Support
to Disabled and reboot.  

There is a small chance that you will also have to set the IRQ's of all
device manually. 

Sean

