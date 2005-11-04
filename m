Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVKDSw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVKDSw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVKDSw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:52:56 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:37353 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1750748AbVKDSwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:52:55 -0500
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: David Brownell <david-b@pacbell.net>
Cc: eemike@gmail.com, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200511031615.22630.david-b@pacbell.net>
References: <200511031615.22630.david-b@pacbell.net>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Fri, 04 Nov 2005 10:52:45 -0800
Message-Id: <1131130365.426.33.camel@localhost.localdomain>
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

On Thu, 2005-11-03 at 16:15 -0800, David Brownell wrote:
> Stephen persuaded me to add controller_data too, which is stored in
> "struct spi_device".  His PXA SPI controller driver uses that for a
> structure holding what I'd call DMA tuning information, plus a function
> that tweaks the GPIO used for a chipselect.  Treat it as readonly.
> 
> Controller drivers can have two different kinds of state in each
> spi_device:  static, and dynamic/runtime.  The names used for them
> are IMO very confusing (platform_data and controller_data) since
> they don't mean the same as those names do in board_info.  I'd take
> a patch to provide better names for those two.  :)

I agree, the names are bad...  How about modifying struct spi_board_info
to

struct spi_board_info {
...

	void *slave_data;
	void *master_data; 
...
};

-Stephen




