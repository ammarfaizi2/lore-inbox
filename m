Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVGLRID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVGLRID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVGLRFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:05:25 -0400
Received: from totor.bouissou.net ([82.67.27.165]:46999 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261655AbVGLRDx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:03:53 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Tue, 12 Jul 2005 19:03:49 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507121004080.4996-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507121004080.4996-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507121903.49792@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 12 Juillet 2005 16:12, Alan Stern a écrit :
>
> Okay, the patch (for 2.6.12) is below.  It does several things:
>
> 	Prevents the system from reading the port status registers,
> 	so the computer won't know when any devices are plugged in.
>
> 	Makes the system think there always is a device plugged in,
> 	so it will never automatically suspend the controllers.
>
> 	Leaves all the interrupt-enable bits turned off, so the
> 	controllers won't ever generate an interrupt request.
>
> 	Prints a message to the system log every time the interrupt
> 	handler is called.
>
> In case it's not already clear, when you install this patch the UHCI
> controllers will not be useable.

Okay, the patch applied easily and the kernel is now compiling. When 
installed, I'll try and boot it (and will use a PS/2 mouse instead of my 
current USB mouse, or should I rather try to plug my USB mouse to the 
ehci_hcd controller ?).

How would you like me to boot ? With or without the "usb-handoff" option ? 
With or without the BIOS "USB mouse support" option ?

And once booted, what information will you be interested in ?

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
