Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTF0CpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTF0Cor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:44:47 -0400
Received: from dp.samba.org ([66.70.73.150]:33752 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263535AbTF0CnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:43:18 -0400
Date: Fri, 27 Jun 2003 12:55:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Pavel Roskin <proski@gnu.org>
Cc: Manuel Estrada Sainz <ranty@debian.org>,
       LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
       orinoco-devel@lists.sourceforge.net, jt@hpl.hp.com
Subject: Re: [Orinoco-devel] orinoco_usb Request For Comments
Message-ID: <20030627025536.GG1521@zax>
Mail-Followup-To: Pavel Roskin <proski@gnu.org>,
	Manuel Estrada Sainz <ranty@debian.org>,
	LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
	orinoco-devel@lists.sourceforge.net, jt@hpl.hp.com
References: <20030626205811.GA25783@ranty.pantax.net> <Pine.LNX.4.56.0306261734230.3732@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0306261734230.3732@marabou.research.att.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 06:03:23PM -0400, Pavel Roskin wrote:
> On Thu, 26 Jun 2003, Manuel Estrada Sainz wrote:
> 
> >  I now believe that it is stable enough for the kernel, and I would like
> >  to get it integrated in the official kernel tree.
> >
> >  At first I tried convincing David to accept the changes in the standard
> >  orinoco driver but he was (rightfully) skeptic. Then Jean Tourrilhes
> >  opened my eyes, the changes touch carefully crafted locking semantics
> >  and could give trouble (although it has been working well for quite a
> >  while), and suggested adding it as an independent (alternative) driver.
> 
> I think it's a reasonable request.  It's a pity that the future work on
> the Orinoco driver won't be integrated into your driver automatically.  In
> particular, scanning, monitor mode and switching to the separate wireless
> handlers may be useful for the USB driver as well.

Indeed.  I certainly hope that at some point we can share at least
parts of the code between the drivers.  I just haven't seen a good way
to do it yet.

> But indeed, Orinoco USB is very different from other Orinoco cards.  There
> is a firmware that stands between the driver and the PCMCIA card, and that
> firmware is less transparent than, say, PLX bridges.

Quite true.  I suspect we will never be able to cleanly merge the core
of the Rx and Tx paths.  With luck though, we'll be able to share code
for implementing the wireless extensions, some other support routines,
and maybe parts of initialization.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
