Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTIAWae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTIAWae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:30:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48135 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263343AbTIAWa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:30:27 -0400
Date: Mon, 1 Sep 2003 23:30:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901233023.F22682@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <20030831232812.GA129@elf.ucw.cz> <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org> <20030901211220.GD342@elf.ucw.cz> <20030901225243.D22682@flint.arm.linux.org.uk> <20030901221920.GE342@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030901221920.GE342@elf.ucw.cz>; from pavel@suse.cz on Tue, Sep 02, 2003 at 12:19:20AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 12:19:20AM +0200, Pavel Machek wrote:
> > Please don't - that means undoing all the work I've put in to make
> > ARM work again, and I don't have time to play silly games like this.
> 
> Okay, so Patrick broke ARM and you fixed it. But he also broke i386 and
> x86-64; and it is not at all clear that his "newer" version is better
> than the old one. [Really, what's the advantage? AFAICS it is more
> complicated and less flexible, putting "suspend" method to bus as
> oppossed to device].

I don't think PCI device support broke - Pat seems to have fixed up
all that fairly nicely, so the driver model change should be
transparent.

The main advantage from a driver writers point of view is the disposal
of the "level" argument.  (Doesn't really affect x86, PCI drivers never
had visibility of this.)

However, I'll let the PPC people justify the real reason for the driver
model change, since it was /their/ requirement that caused it, and I'm
not going to fight their battles for them.  (although I seem to be doing
exactly that while wasting my time here.)

It's about time that the people in the PPC community, who were the main
guys pushing for the driver model change, spoke up and justified this.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

