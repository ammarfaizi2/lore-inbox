Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWGFSsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWGFSsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWGFSsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:48:40 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:7423 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750729AbWGFSsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:48:40 -0400
Date: Thu, 6 Jul 2006 20:48:21 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060706204821.06540ab4@cad-250-152.norway.atmel.com>
In-Reply-To: <1152196492.2987.185.camel@pmac.infradead.org>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<1152187083.2987.117.camel@pmac.infradead.org>
	<20060706161319.3ae0d9ef@cad-250-152.norway.atmel.com>
	<1152196492.2987.185.camel@pmac.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 15:34:52 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Thu, 2006-07-06 at 16:13 +0200, Haavard Skinnemoen wrote:

> > As I understand it, though, drivers/dma is mostly for
> > memory-to-memory to transfers, while what I really need is
> > memory-to-hardware and hardware-to-memory transfers.
> 
> With MMIO those are just a not-so-special case of memory-memory,
> surely? If the new framework doesn't support that, it probably
> _should_.

Yes, but there are at least two important differences:

   * Hanshaking. The DMA controller must know when the peripheral has
     new data available/is able to accept more data. Thus, you need to
     specify which set of handshaking signals to use as well as which
     direction the data is moved.
   * One of the pointers often stays the same during the whole transfer.

I'm willing to give the drivers/dma framework a try, though, when the
time comes to forward-port the drivers that need such infrastructure.

Håvard
