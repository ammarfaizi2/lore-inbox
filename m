Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUDLQbb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 12:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUDLQbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 12:31:25 -0400
Received: from d64-180-152-77.bchsia.telus.net ([64.180.152.77]:49415 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S262941AbUDLQbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 12:31:21 -0400
Date: Mon, 12 Apr 2004 09:29:16 -0700
From: Jeremy Martin <martinjd@csc.uvic.ca>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tuntap oversight
Message-ID: <20040412162916.GA5046@net-ronin.org>
References: <20040412065947.GC18810@net-ronin.org> <20040412001551.05476658.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040412001551.05476658.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 12:15:51AM -0700, David S. Miller wrote:
> 
> This netif_running() check is not necessary, and in fact
> wrong.
> 
> In fact, if ethernet drivers erroneously do this, this causes
> them to fail to support the ALB bonding driver modes which
> require on-the-fly MAC address changes while the interface is
> up.
> 

I just took a look in drivers/net/
and 
	acenic.c
	atarilance.c
	b44.c
	cs89x0.c
	net_init.c
	typhoon.c

all use that netif_running() check when setting the MAC.  I actually just pulled
the function from net_init.c for the tun change.  Are these broken?
(I'm asking in total ignorance so be gentle :).

-Jeremy
