Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTIVP5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbTIVP43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:56:29 -0400
Received: from pop.gmx.net ([213.165.64.20]:23502 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263221AbTIVPz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:55:27 -0400
X-Authenticated: #536991
Date: Mon, 22 Sep 2003 17:55:24 +0200
From: Robert Vollmert <rvollmert-lists@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Local APIC with ACPI freezes ASUS M2400N
Message-ID: <20030922155524.GA8167@krikkit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when Local APIC is enabled, my ASUS M2400N notebook (Centrino / ICH4-M
chipset) freezes when ACPI initialises or tries to switch the display
device. When Local APIC is not enabled, this does not occur. This
happens both with 2.4.22 with ACPI patch from 20030916 and with
unpatched (apart from a patch to load the DSDT via initrd)
2.6.0-test5.

On 2.4.22, it is possible to avoid the freeze during boot-up by
disabling the vga console. I haven't tested this on 2.6.0-test5.

The freeze occurs when the DSDT writes to SystemIO address 0xb2. It
does this both to query information about the active display device
and to change the device.

I haven't been able to determine which of these writes exactly causes
the freeze. When booting successfully by modifying the DSDT to bypass
initialisation of the VGA device, it was possible to read the display
status successfully a few times before a read caused the system to
freeze.

If there's some more information you need, please let me know.

Cheers
Robert
