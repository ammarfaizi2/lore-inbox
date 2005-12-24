Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVLXVYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVLXVYs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 16:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVLXVYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 16:24:48 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:24471 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750728AbVLXVYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 16:24:47 -0500
Date: Sat, 24 Dec 2005 22:20:57 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Ayaz Abdulla <AAbdulla@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: [PATCH] forcedeth: fix random memory scribbling bug
Message-ID: <20051224212057.GA22117@electric-eye.fr.zoreil.com>
References: <43AD4ADC.8050004@colorfullife.com> <Pine.LNX.4.64.0512241145520.14098@g5.osdl.org> <43ADA7D0.9010908@colorfullife.com> <Pine.LNX.4.64.0512241241230.14098@g5.osdl.org> <43ADB83A.4090005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ADB83A.4090005@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> Paranoia -- the situation above never occurs.  It is coded as are other 
> drivers:  np->rx_buf_sz only changes in ->change_mtu(), which (a) is 
> serialized against close and (b) always stops the engine and drains RX 
> skbs before changing the size.

Yep.

Btw, regarding the "more sense" thing, now:
- pci_{map/unmap}_single() uses skb->foo
- nv_alloc_rx() and friends use np->rx_buf_sz

(thread moved to netdev@vger.kernel.org)

--
Ueimor
