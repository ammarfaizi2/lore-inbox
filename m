Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUJLV60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUJLV60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUJLV60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:58:26 -0400
Received: from waste.org ([209.173.204.2]:2788 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267903AbUJLV6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:58:02 -0400
Date: Tue, 12 Oct 2004 16:57:32 -0500
From: Matt Mackall <mpm@selenic.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: netdev@oss.sgi.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] netconsole support for b44
Message-ID: <20041012215732.GV31237@waste.org>
References: <416BC26B.6090603@kolivas.org> <20041012180949.GW5414@waste.org> <416C5122.9040001@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416C5122.9040001@kolivas.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 07:48:18AM +1000, Con Kolivas wrote:
> Matt Mackall wrote:
> >On Tue, Oct 12, 2004 at 09:39:23PM +1000, Con Kolivas wrote:
> >
> >>This patch adds poll support to the b44 driver to allow netconsole 
> >>support. Style lifted straight from 8139too.c
> >>
> >>here is the dmesg output with it in place:
> >>
> >>netconsole: device eth0 not up yet, forcing it
> >>netconsole: carrier detect appears flaky, waiting 10 seconds
> >>b44: eth0: Link is down.
> >>b44: eth0: Link is up at 100 Mbps, full duplex.
> >>b44: eth0: Flow control is on for TX and on for RX.
> >>netconsole: network logging started
> >>
> >>output confirmed by netcat on other system.
> >>
> >>Signed-off-by: Con Kolivas <kernel@kolivas.org>
> >
> >
> >+       disable_irq(dev->irq);
> >+       b44_interrupt (dev->irq, dev, NULL);
> >+       enable_irq(dev->irq);
> >
> >Aside from this bizarre whitespace convention and neglecting to cc:
> >me, looks good.
> >
> 
> sorry,sorry,thanks.
> 
> Can you explain where I went wrong in the whitespace so I don't make the 
> same mistake again? It looked pretty standard to me.

Stray space between b44_interrupt and args. 

> Should I nudge akpm with this or will it go via another route?

Jeff Garzik usually picks up net driver stuff, I think he got this one.

-- 
Mathematics is the supreme nostalgia of our time.
