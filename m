Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275871AbSIUDl7>; Fri, 20 Sep 2002 23:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275872AbSIUDl7>; Fri, 20 Sep 2002 23:41:59 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:7924 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S275871AbSIUDl7>; Fri, 20 Sep 2002 23:41:59 -0400
Date: Fri, 20 Sep 2002 23:47:05 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-ns83820@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ns83820.c v0.20 -- a brown paper bag edition
Message-ID: <20020920234705.A32159@redhat.com>
References: <20020920223424.B30874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020920223424.B30874@redhat.com>; from bcrl@redhat.com on Fri, Sep 20, 2002 at 10:34:24PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 10:34:24PM -0400, Benjamin LaHaise wrote:
> Hey Marcelo et al,
> 
> Ummm, I screwed up.  The v0.19 patch for ns83820.c I sent yesterday killed 
> the ability of the driver to receive packets.  Instead, apply this shiny 
> new ns83820.c v0.20 patch that has all the amazing goodness of 0.19, plus 
> the ability to receive packets!

And I did it again.  Please apply the following patch on top of the other.  
Ugggggggh.

		-ben


Index: linux/drivers/net/ns83820.c
===================================================================
RCS file: /home/bcrl/CVSROOT/ns83820/drivers/net/ns83820.c,v
retrieving revision 1.34.2.24
diff -u -u -r1.34.2.24 linux/drivers/net/ns83820.c
--- linux/drivers/net/ns83820.c	21 Sep 2002 03:33:08 -0000	1.34.2.24
+++ linux/drivers/net/ns83820.c	21 Sep 2002 04:40:55 -0000
@@ -1001,7 +1001,6 @@
 					le32_to_cpu(desc[DESC_CMDSTS]) & CMDSTS_LEN_MASK,
 					PCI_DMA_TODEVICE);
 			dev_kfree_skb_irq(skb);
-			dev_kfree_skb(skb);
 			atomic_dec(&dev->nr_tx_skbs);
 		}
 	}
