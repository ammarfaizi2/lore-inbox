Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWGFXQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWGFXQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWGFXQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:16:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2533 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751026AbWGFXQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:16:57 -0400
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060706204821.06540ab4@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	 <1152187083.2987.117.camel@pmac.infradead.org>
	 <20060706161319.3ae0d9ef@cad-250-152.norway.atmel.com>
	 <1152196492.2987.185.camel@pmac.infradead.org>
	 <20060706204821.06540ab4@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 00:17:11 +0100
Message-Id: <1152227832.22035.3.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 20:48 +0200, Haavard Skinnemoen wrote:
> > With MMIO those are just a not-so-special case of memory-memory,
> > surely? If the new framework doesn't support that, it probably
> > _should_.
> 
> Yes, but there are at least two important differences:
> 
>    * Hanshaking. The DMA controller must know when the peripheral has
>      new data available/is able to accept more data. Thus, you need to
>      specify which set of handshaking signals to use as well as which
>      direction the data is moved.
>    * One of the pointers often stays the same during the whole transfer. 

Those are hardly esoteric features -- the same goes for just about every
sane DMA controller on every architecture already. Any "generic DMA
framework" which isn't entirely crack-inspired is surely going to handle
it properly.

-- 
dwmw2

