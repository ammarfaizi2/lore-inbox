Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbUBXMoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 07:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbUBXMoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 07:44:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35854 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262241AbUBXMoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 07:44:11 -0500
Date: Tue, 24 Feb 2004 12:44:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Roskin <proski@gnu.org>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Andrew Morton <akpm@osdl.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges
Message-ID: <20040224124407.B30975@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Roskin <proski@gnu.org>,
	Daniel Ritz <daniel.ritz@gmx.ch>, Andrew Morton <akpm@osdl.org>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200402240033.31042.daniel.ritz@gmx.ch> <20040224000051.C25358@flint.arm.linux.org.uk> <Pine.LNX.4.58.0402231920110.30605@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0402231920110.30605@marabou.research.att.com>; from proski@gnu.org on Mon, Feb 23, 2004 at 07:46:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 07:46:35PM -0500, Pavel Roskin wrote:
> On Tue, 24 Feb 2004, Russell King wrote:
> > On Tue, Feb 24, 2004 at 12:33:31AM +0100, Daniel Ritz wrote:
> > > this patch should fix up wrongly initialized TI bridges. in a safe way
> > > (hopefully).
> >
> > Unfortunately not.
> 
> I admire your ability to see problems so fast.

Only because I've hit this problem before.  With the original IRQMUX
patches, they managed to probe the available IRQs (finding IRQ3 and IRQ4
available) and then changed IRQMUX preventing these signals working.

The net result was that an inserted card was allocated IRQ3 or IRQ4
and no surprises that it was unable to signal its interrupt.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
