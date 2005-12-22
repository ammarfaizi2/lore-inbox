Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVLWATU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVLWATU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVLWATK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:19:10 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:37549 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751232AbVLWASz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:18:55 -0500
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH/RFC] SPI:  async message handing library update
Date: Thu, 22 Dec 2005 15:55:16 -0800
User-Agent: KMail/1.7.1
Cc: Vitaly Wool <vwool@ru.mvista.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512220928.34457.david-b@pacbell.net> <43AB243F.1000505@ru.mvista.com>
In-Reply-To: <43AB243F.1000505@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512221555.17605.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> BTW: the message handling is one per-transfer basis for bitbang. But in 
> this case it's not possible to imlement chained DMA transfers (2 
> channels, one for Rx, one for Tx, basically that's your sample use case :)

This library code is intended to help folk get some functional and correct
drivers quickly ... with "chained DMA" support being explicitly a non-goal.

If you want a top performing driver, you'd go about it differently ... you
would handle all the transfers directly, and not use library code like this.
Every SOC seems to have its own preferred way to do DMA chaining, so likely
the driver would just implement the three spi_master methods directly and
map most spi_message objects into single SOC-specific DMA chains.

- Dave

