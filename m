Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268524AbTBWSuT>; Sun, 23 Feb 2003 13:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268525AbTBWSuT>; Sun, 23 Feb 2003 13:50:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43022 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268524AbTBWSuS>; Sun, 23 Feb 2003 13:50:18 -0500
Date: Sun, 23 Feb 2003 10:57:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
In-Reply-To: <20030223173441.D20405@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302231054420.11584-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, Russell King wrote:
> 
> Linus - this patch is for discussion, NOT for applying unless you have
> zero problems with it since it actively breaks existing hotplug PCI.

Well, I definitely want it, and you should add Alan to the cc list since 
he apparently even _has_ one of these devices.

I don't have any objections to the patch, but I won't apply it until the 
otehr PCI people have had a chance to weigh in on it.

> Furthermore, I propose that pci_remove_device() shall disappear -
> and this devices makes it so (thereby breaking existing hotplug
> drivers.)

Can't you just fix up the current users to use "pci_remove_bus_device()". 
The breakage seems a bit spiteful ;)

			Linus

