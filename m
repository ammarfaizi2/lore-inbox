Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268020AbUH3NYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268020AbUH3NYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbUH3NYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:24:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64444 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268020AbUH3NYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:24:45 -0400
Date: Mon, 30 Aug 2004 08:10:27 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Peter Holik <peter@holik.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: fix fealnx.c hangs on SMP, 2.4.27
Message-ID: <20040830111027.GA1961@logos.cnet>
References: <38386.192.168.1.2.1093850895.squirrel@www.it-technology.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38386.192.168.1.2.1093850895.squirrel@www.it-technology.at>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 09:28:15AM +0200, Peter Holik wrote:
> static void set_rx_mode(struct net_device *dev)
> {
>    spinlock_t *lp = &((struct netdev_private *)dev->priv)->lock;
>    unsigned long flags;
>    spin_lock_irqsave(lp, flags);
>    __set_rx_mode(dev);
> -  spin_unlock_irqrestore(&lp, flags);
> +  spin_unlock_irqrestore(lp, flags);
> }

Peter,

This has just been merged in v2.4 BK repo. 


