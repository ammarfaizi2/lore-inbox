Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVK3V7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVK3V7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVK3V7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:59:16 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:60830 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1750995AbVK3V7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:59:15 -0500
Subject: Re: [PATCH 2.6-git] SPI core refresh
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: David Brownell <david-b@pacbell.net>
Cc: Vitaly Wool <vwool@ru.mvista.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
In-Reply-To: <200511301336.38613.david-b@pacbell.net>
References: <20051130195053.713ea9ef.vwool@ru.mvista.com>
	 <200511301336.38613.david-b@pacbell.net>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Wed, 30 Nov 2005 13:59:10 -0800
Message-Id: <1133387950.4528.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 13:36 -0800, David Brownell wrote:
> > - it is DMA-safe
> 
> Which as I pointed out is incorrect.  The core API (async) has always
> been fully DMA-safe.  And a **LOT** lower overhead than yours, which
> allocates buffers behind the back of drivers, and encourages lots of
> memcpy rather than just doing DMA directly to/from the buffers that
> are provided by the SPI protocol drivers.

Minimal (or no) core intervention on the DMA code path is a good thing.
I need to fix some broken hardware with software and must to move 96
bytes from one SPI device to another on the same SPI bus every for 4ms.
Needless memcpy's will cause substantial performance problems in my
application. Thinner is definitely better.

-Stephen

