Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269358AbTCDUJ5>; Tue, 4 Mar 2003 15:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269536AbTCDUJ5>; Tue, 4 Mar 2003 15:09:57 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:7904 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S269358AbTCDUJ4>; Tue, 4 Mar 2003 15:09:56 -0500
Date: Tue, 4 Mar 2003 20:47:32 +0100
From: Dominik Brodowski <linux@brodo.de>
To: jt@hpl.hp.com
Cc: Patrick Mochel <mochel@osdl.org>, torvalds@transmeta.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       mika.penttila@kolumbus.fi
Subject: Re: [PATCH] pcmcia: get initialization ordering right [Was: [PATCH 2.5] : i82365 & platform_bus_type]
Message-ID: <20030304194732.GA1055@brodo.de>
References: <20030304171640.GA16366@bougret.hpl.hp.com> <Pine.LNX.4.33.0303041123210.992-100000@localhost.localdomain> <20030304185428.GA16945@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304185428.GA16945@bougret.hpl.hp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 10:54:28AM -0800, Jean Tourrilhes wrote:
> On Tue, Mar 04, 2003 at 11:48:22AM -0600, Patrick Mochel wrote:
> > 
> > Surely you're sore that your code has required some modifications since
> > Dominik has started working on PCMCIA, and I'm sure that no harm was
> > intended. It's had some bumps, but IMO, he's done a great job, and the 
> > result is a vast improvement. The least you could is give the guy some 
> > slack, instead of whining about your own inconveniences. 
> 
> 	I don't mind the changes, changes are usually good. In 2.5.X,
> I had to change my code to accomodate the new PCI interface, the
> removal of global IRQ, the new module interface, the various USB API
> changes and other changes. And actually, your work currently hasn't
> had any impact on the source code I follow (yet).
> 	What I mind is the lack of basic testing. From your patch, the
> initialisation order mixup and the other obvious bug fix I sent you,
> this code had zero chances of working at all and it's obvious that
> nobody bothered to check if it could work or not for at least two
> kernel releases.

The problem is that I only have one yenta-compatible cardbus controller, and
one pcmcia card -- no real "infrastructure" to test the patches.[*] And I
really try to verify that my patches work, but obviously I had a bad day
when I wrote the "let's add a pcmcia socket devices class" patch.
Nonetheless, one point you mention is perfectly valid -- the kernel is in 
a feature freeze.

	Dominik

[*] Needless to say, the patches I sent tend to work on the hardware I
own...
