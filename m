Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTIMWEz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbTIMWEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:04:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51204 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262225AbTIMWEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:04:54 -0400
Date: Sat, 13 Sep 2003 23:04:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
       Thomas Molina <tmolina@cablespeed.com>
Subject: Re: presario laptop pcmcia loading problems
Message-ID: <20030913230450.B23169@flint.arm.linux.org.uk>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
	Thomas Molina <tmolina@cablespeed.com>
References: <Pine.LNX.4.44.0309121603280.1579-800000@localhost.localdomain> <20030913212719.A23169@flint.arm.linux.org.uk> <20030913205615.GK27104@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030913205615.GK27104@triplehelix.org>; from joshk@triplehelix.org on Sat, Sep 13, 2003 at 01:56:15PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 01:56:15PM -0700, Joshua Kwan wrote:
> On Sat, Sep 13, 2003 at 09:27:19PM +0100, Russell King wrote:
> > > # CONFIG_ISA is not set
> > 
> > Turn this on.
> 
> How about requiring CONFIG_ISA for CONFIG_PCMCIA_HERMES?

It's unrelated to Hermes.

Turning off CONFIG_ISA drops out a chunk of code to do with ISA support,
including support for ISA-style interrupts from PCMCIA.  However, PCMCIA
cards are still useful if your cardbus socket routes PCMCIA card
interrupts to the PCI interrupt.

What I basically need to do (when I get around to it) is to work out
a decent way to handle routing the cardbus/pcmcia interrupts according
to what resources are available.  But alas, time is a commodity which
I'm sorely lacking at the moment.

So for the moment, if you want to use PCMCIA cards, always ensure you
have CONFIG_ISA turned on.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
