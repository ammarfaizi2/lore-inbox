Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbTHWNuL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 09:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbTHWNuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 09:50:10 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:32738 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263230AbTHWNuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 09:50:06 -0400
Date: Sat, 23 Aug 2003 15:42:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [bk patches] net driver updates
Message-ID: <20030823154231.A11381@electric-eye.fr.zoreil.com>
References: <20030817183137.GA18521@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030817183137.GA18521@gtf.org>; from jgarzik@pobox.com on Sun, Aug 17, 2003 at 02:31:37PM -0400
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[net-drivers-2.6 update]
>  drivers/net/sis190.c              | 2094 +++++++++++++++++++++++++++++---------


synchronize_irq() requires an argument when built with CONFIG_SMP.


 drivers/net/sis190.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/net/sis190.c~synchronize_irq-missing-arg-sis190 drivers/net/sis190.c
--- linux-2.6.0-test4/drivers/net/sis190.c~synchronize_irq-missing-arg-sis190	Sat Aug 23 15:37:35 2003
+++ linux-2.6.0-test4-fr/drivers/net/sis190.c	Sat Aug 23 15:37:35 2003
@@ -1111,7 +1111,7 @@ SiS190_close(struct net_device *dev)
 
 	spin_unlock_irq(&tp->lock);
 
-	synchronize_irq();
+	synchronize_irq(dev->irq);
 	free_irq(dev->irq, dev);
 
 	SiS190_tx_clear(tp);

_
