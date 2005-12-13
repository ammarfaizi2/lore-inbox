Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVLMWsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVLMWsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbVLMWsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:48:51 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54727
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030328AbVLMWsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:48:50 -0500
Date: Tue, 13 Dec 2005 14:48:54 -0800 (PST)
Message-Id: <20051213.144854.73497707.davem@davemloft.net>
To: hch@lst.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] move rtc compat ioctl handling to fs/compat_ioctl.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051213172312.GA16392@lst.de>
References: <20051213172312.GA16392@lst.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 13 Dec 2005 18:23:12 +0100

> This patch implements generic handling of RTC_IRQP_READ32, RTC_IRQP_SET32,
> RTC_EPOCH_READ32 and RTC_EPOCH_SET32 in fs/compat_ioctl.c.  It's based on
> the x86_64 code which needed a little massaging to be endian-clean.
> 
> parisc used COMPAT_IOCTL or generic w_long handlers for these whichce
> is wrong and can't work because the ioctls encode sizeof(unsigned long)
> in their ioctl number.  parisc also duplicated COMPAT_IOCTL entries for
> other rtc ioctls which I remove in this patch, too.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.
