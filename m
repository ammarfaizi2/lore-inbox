Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUH3JFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUH3JFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 05:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267514AbUH3JFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 05:05:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64937 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267507AbUH3JFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 05:05:12 -0400
Message-ID: <4132EDB9.3020400@pobox.com>
Date: Mon, 30 Aug 2004 05:04:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Holik <peter@holik.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: fix fealnx.c hangs on SMP, 2.4.27
References: <38386.192.168.1.2.1093850895.squirrel@www.it-technology.at>
In-Reply-To: <38386.192.168.1.2.1093850895.squirrel@www.it-technology.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Holik wrote:
> static void set_rx_mode(struct net_device *dev)
> {
>    spinlock_t *lp = &((struct netdev_private *)dev->priv)->lock;
>    unsigned long flags;
>    spin_lock_irqsave(lp, flags);
>    __set_rx_mode(dev);
> -  spin_unlock_irqrestore(&lp, flags);
> +  spin_unlock_irqrestore(lp, flags);
> }


Yep, I sent this fix to Marcelo on Aug 28th.

	Jeff


