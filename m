Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268804AbTCCU65>; Mon, 3 Mar 2003 15:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268805AbTCCU65>; Mon, 3 Mar 2003 15:58:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21263 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268804AbTCCU64>; Mon, 3 Mar 2003 15:58:56 -0500
Date: Mon, 3 Mar 2003 21:09:21 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Hinds <dhinds@sonic.net>
Cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fallback to PCI IRQs for TI bridges
Message-ID: <20030303210921.D17997@flint.arm.linux.org.uk>
Mail-Followup-To: David Hinds <dhinds@sonic.net>,
	Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0302281944470.6367-100000@marabou.research.att.com> <20030301093814.A6700@sonic.net> <Pine.LNX.4.50.0303031203300.17551-100000@marabou.research.att.com> <20030303125620.A26220@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030303125620.A26220@sonic.net>; from dhinds@sonic.net on Mon, Mar 03, 2003 at 12:56:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 12:56:20PM -0800, David Hinds wrote:
> > I think it CONFIG_ISA is meant to be that.  The "ISA support" is so
> > trivial from the kernel perspective, that the line between systems with
> > and without ISA is somewhat blurred.
> 
> I don't really know what the scope of CONFIG_ISA should be.  I think
> now it is mainly used to show or hide drivers for ISA cards, rather
> than describing a system capability.

In my bunch of PCMCIA/Cardbus/PCI changes, I have one patch which
decouples CONFIG_ISA from the PCMCIA subsystem, replacing it with
CONFIG_PCMCIA_PROBE - on statically mapped PCMCIA systems (eg, SA1110)
all the region probing, resource handling, and interrupt stuff is
rather heavy weight.  However, decoupling it from CONFIG_ISA would
allow all that supporting code to remain when required for some socket
drivers.

I'm working through getting stuff tested and in to Linus in a reasonable
way.  Of course, this won't help for 2.4 based kernels, although the
CONFIG_PCMCIA_PROBE has existed in the ARM tree for a fair while and
could, given someone with enough motivation, the relevant changes could
be dug out and submitted to Marcello.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

