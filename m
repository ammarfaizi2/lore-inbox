Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUDOMVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 08:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUDOMVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 08:21:38 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:61201 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S262981AbUDOMVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 08:21:36 -0400
Date: Thu, 15 Apr 2004 13:58:03 +0200
From: DervishD <raul@pleyades.net>
To: Adam Belay <ambx1@neo.rr.com>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Confused about 2.6 PnP support
Message-ID: <20040415115803.GB7258@DervishD>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040412170515.GA670@DervishD> <20040414050838.GB8473@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040414050838.GB8473@neo.rr.com>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Adam, and thanks for your answer :)

 * Adam Belay <ambx1@neo.rr.com> dixit:
> >     AFAIK, PnP, strictly speaking, has nothing to do with the PCI
> > bus, but I think is common notation to talk about PnP referring
> > autoconfiguration of PCI cards, and I want to know if I need to
> > select PCI support for having my PCI cards correctly detected and
> > configured (currently my BIOS does the work), or if the PnP support
> > in kernel 2.6 is just for ISA cards. In addition to this, the PnP
> > BIOS support (which I think I may need so Linux correctly gets the
> > IO, IRQ and DMA settings for my parallel port) is marked as
> > EXPERIMENTAL (at least in 2.6.5)
> In this context PnP is refering to configuration of system and ISA
> devices.

    But then, why it depends on ISA support?

    BTW, in the case of my printer, the log says:

parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready

    The question is that my parallel port is configured as EPP, using
DMA 3, not as SPP, and I'm not sure if the problem is on the kernel,
the motherboard or if it is a simple matter of notation and the port
is being properly detected. My /proc/sys/dev/parport says
PCSPP,TRISTATE, not EPP... But DMA channel, IRQ line and IO addresses
are being correctly detected, so this doesn't seem a problem of PnP.

> >     I want to know if I must tell my BIOS I don't have a PnP OS or
> > if, on the contrary, I should tell my BIOS that my OS is not PnP (I
> > only use Linux) and deselect PnP support (as well as ISA support) in
> > my 2.6.x kernel. Personally, I don't mind setting 'Non PnP OS' in my
> > BIOS and remove both CONFIG_ISA and CONFIG_PNP.
> If you are using PnPBIOS support then set PNP OS to "yes", otherwise use
> "no".

    So if I don't want ISA support in my kernel I must go with PNP OS
set to 'no' and let the BIOS do the work, am I right?
 
> >     BTW, ?does Linux support rebalancing of PnP bus resources or I
> > better avoid conflicts...?
> Yes, see sysfs and drivers/pnp/interface.c.  Resources can be
> reallocated but only if the device is not bound to a driver
> (modules are useful for this).

    Cool :)) Thanks for the information.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
