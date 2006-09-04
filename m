Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWIDMb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWIDMb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWIDMb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:31:27 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:19846 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S964837AbWIDMb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:31:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:in-reply-to:user-agent;
	b=EpojoIaE0ChMgT7xc7WYiJ0JZ9Yw1vX8qGIRa9B2Oh8ClLvLyz+W1XK3gzzlV
	2I1+7bokl9tOgE1Ih24NoG1FQ==
Date: Mon, 4 Sep 2006 14:31:23 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       "Kok, Auke" <auke-jan.h.kok@intel.com>
Subject: Re: [RFT] e100 driver on ARM
Message-ID: <20060904123123.GB1285@xi.wantstofly.org>
References: <44FC0261.6010807@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FC0261.6010807@garzik.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 06:39:29AM -0400, Jeff Garzik wrote:

> 1) Does e100 driver work on ARM?

FWIW, e100 seems to work okay for me on an intel ixp2400 (xscale based)
board, an ixp2850 (xscale based) board and an ixp2350 (xscale3 based)
board.  ixp2350 works both with hardware coherency turned on (cpu
snoops bus) and turned off (manual dma cache clean/invalidate as usual.)

As for the other ARM platforms that I'm interested in / have hardware
for / maintain, the at91/ep93xx/pxa270 don't have PCI, and the other
two (iop32x/iop33x) I can't test because I don't have such systems with
e100 NICs, but I expect those would work, since they're both xscale
based like the ixp2400, and the ixp2400 works.


cheers,
Lennert

-- 
VGER BF report: H 6.97804e-11
