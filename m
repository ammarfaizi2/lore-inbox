Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVA3RFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVA3RFM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 12:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVA3RFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 12:05:11 -0500
Received: from alg138.algor.co.uk ([62.254.210.138]:59116 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261737AbVA3REm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 12:04:42 -0500
Date: Sun, 30 Jan 2005 16:58:39 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [PATCH] Fix SERIAL_TXX9 dependencies
Message-ID: <20050130165839.GB27703@linux-mips.org>
References: <20050129131134.75dacb41.akpm@osdl.org> <20050130001555.GA3648@linux-mips.org> <20050130.220537.45151614.anemo@mba.ocn.ne.jp> <200501301645.14069.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501301645.14069.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 04:45:08PM +0100, Arnd Bergmann wrote:

> > Well, "depends on MIPS || PCI" was intentional.  The driver can be
> > used for both TX39/TX49 internal SIO and TC86C001 PCI chip.  TC86C001
> > chip can be available for any platform with PCI bus (though I have
> > never seen it on platform other than MIPS ...)
>  	
> There is at least one device that uses the same uart on a non-MIPS
> platform. I'll submit a patch once I have it working.
> 
> > So I suppose "depends on HAS_TXX9_SERIAL || PCI" might be better, but
> > Ralf's patch will be OK for now.
> 
> Right. There is however one bigger problem with the original patch:
> It removes the driver for tx3912 and adds one for tx3927/tx49xx.
> AFAICS, the 3912 has a very different register layout from the other
> chips, so the old driver must not be removed yet.

Hmm...  Atushi sent me this new-style serial driver when I asked him for
replacements for the old style drivers in drivers/char/ so my undertanding
was it was a full replacement for all of them.  I'll check on the tx3912
and will try to send an update later today.

  Ralf
