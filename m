Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272325AbTG1CB3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272064AbTG1ABV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:21 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272940AbTG0XB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:56 -0400
Date: Sun, 27 Jul 2003 20:21:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com, willy@debian.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] Re: Firmware loading problem
Message-ID: <20030727192111.GT1485@parcelfarce.linux.theplanet.co.uk>
References: <1058885139.2757.27.camel@pegasus> <20030722145546.GC23593@ranty.pantax.net> <1058888301.2755.8.camel@pegasus> <20030726090458.GA16634@ranty.pantax.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030726090458.GA16634@ranty.pantax.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 11:04:58AM +0200, Manuel Estrada Sainz wrote:
> 	- hopefully adapt drivers/pci/pci-sysfs.c to this changes
> 		- Please double check, I didn't look very carefully on
> 		  this.

Definitely wrong.  I was going to undo this change since I realised how
it doesn't work for you; but the change you made to the PCI code is wrong.
It ends up copying everything to offset 0 from the buf address.  I wish
Pat had cc'd me when making the change to the interface originally ;-(

I'll whip up a patch in a few minutes.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
