Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWIUJCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWIUJCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 05:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWIUJCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 05:02:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23517 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751028AbWIUJCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 05:02:12 -0400
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Sep 2006 10:26:23 +0100
Message-Id: <1158830784.11109.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-21 am 11:33 +0800, ysgrifennodd Luke Yang:
> Hi,
> 
> This is the serial driver for Blackfin. It is designed for the serial
> core framework.

> +#define DMA_RX_XCOUNT		TTY_FLIPBUF_SIZE

TTY_FLIPBUF_SIZE is going away. Just pick a value good for your hardware
and under PAGE_SIZE.

Other question - is your locking ok for low latency. In low latency mode
tty_flip_buffer_push() may directly end up calling your write methods.

Otherwise looks good

Alan

