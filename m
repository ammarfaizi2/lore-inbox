Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWADWUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWADWUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWADWUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:20:35 -0500
Received: from tim.rpsys.net ([194.106.48.114]:32128 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030288AbWADWUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:20:33 -0500
Subject: Re: [PATCH] PXA2xx: build PCMCIA as a module
From: Richard Purdie <rpurdie@rpsys.net>
To: Florin Malita <fmalita@gmail.com>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <1136409389.14442.20.camel@scox.glenatl.glenayre.com>
References: <1136409389.14442.20.camel@scox.glenatl.glenayre.com>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 22:20:20 +0000
Message-Id: <1136413220.9902.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 16:16 -0500, Florin Malita wrote: 
> This patch adds support for building the PCMCIA driver for pxa2xx Sharp
> platforms as a module:
> 
> 1) platform_scoop_config is currently declared in pxa2xx_sharpsl.c but
> referenced in the platform code - move the declaration in the platform
> code so pxa2xx_sharpsl.c can be built as a module.
> 2) export soc_common_drv_pcmcia_remove which is referenced in
> pxa2xx_base.c.
> 
> Please apply.
> 
> Signed-off-by: Florin Malita <fmalita@gmail.com>

NAK. This breaks poodle, tosa and collie who also use scoop and this
pcmcia driver. I'd suggest moving scoop_pcmcia_config to
arch/arm/common/scoop.c instead. Whilst this means scoop can't be a
module, the hardware isn't going to do much without it so I have no
objection to that.

Richard

