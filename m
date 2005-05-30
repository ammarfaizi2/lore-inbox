Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVE3Wy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVE3Wy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVE3Wve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:51:34 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1509
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261807AbVE3WvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:51:16 -0400
Date: Mon, 30 May 2005 15:50:37 -0700 (PDT)
Message-Id: <20050530.155037.128618730.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: Steven.Hand@cl.cam.ac.uk, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Bug in 2.6.11.11 - udp_poll(), fragments + CONFIG_HIGHMEM
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <E1Dcs8Y-0006bl-00@gondolin.me.apana.org.au>
References: <E1DclTK-0002qE-00@mta1.cl.cam.ac.uk>
	<E1Dcs8Y-0006bl-00@gondolin.me.apana.org.au>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 31 May 2005 07:49:30 +1000

> Thanks for catching this.  The receive queue lock is never taken
> in IRQs (and should never be) so we can simply substitute bh for
> irq.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks Herbert.
