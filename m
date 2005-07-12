Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVGLSP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVGLSP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVGLSP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:15:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49313 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261913AbVGLSPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:15:55 -0400
Date: Tue, 12 Jul 2005 14:15:54 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
In-Reply-To: <200507121903.49792@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507121412490.5351-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Michel Bouissou wrote:

> > In case it's not already clear, when you install this patch the UHCI
> > controllers will not be useable.
> 
> Okay, the patch applied easily and the kernel is now compiling. When 
> installed, I'll try and boot it (and will use a PS/2 mouse instead of my 
> current USB mouse, or should I rather try to plug my USB mouse to the 
> ehci_hcd controller ?).

USB mice generally run at low speed.  This means that you _can't_ plug it 
into an EHCI controller -- the controller will see that it's not a 
high-speed device and will hand it over to a companion controller, which 
in your case will be UHCI.

> How would you like me to boot ? With or without the "usb-handoff" option ? 
> With or without the BIOS "USB mouse support" option ?

Use "usb-handoff" and turn off BIOS USB mouse support.

> And once booted, what information will you be interested in ?

I'll be interested in seeing if you still get the "IRQ 21 nobody cared" 
message.

Alan Stern

