Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTKWBV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 20:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTKWBV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 20:21:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:50131 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263002AbTKWBV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 20:21:28 -0500
Date: Sat, 22 Nov 2003 17:21:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Marco d'Itri" <md@Linux.IT>
cc: linux-kernel@vger.kernel.org
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
In-Reply-To: <20031122235539.GA14576@wonderland.linux.it>
Message-ID: <Pine.LNX.4.44.0311221717130.2379-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Nov 2003, Marco d'Itri wrote:
>
> This is an ASUS A7V600 motherboard, and the second IDE channel does not
> work at all. I verified that it works fine with a 2.4.x kernel.

Can you enable DEBUG in "arch/i386/pci/pci.h" and ACPI debugging and then
report what the system says at bootup both with ACPI enabled, and with 
"pci=noacpi".

For some reason the system decides that your IDE controller is on irq3,
which is clearly wrong. It's on irq15, but somebody told the PCI layer
otherwise.

			Linus

