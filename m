Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSGVFsT>; Mon, 22 Jul 2002 01:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316397AbSGVFsT>; Mon, 22 Jul 2002 01:48:19 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:64680 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S316342AbSGVFsS>; Mon, 22 Jul 2002 01:48:18 -0400
Subject: Re: PATCH: 2.5.27 port thunderlan to the new DMA API
From: Nicholas Miell <nmiell@attbi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <E17WN0K-0007Yb-00@the-village.bc.nu>
References: <E17WN0K-0007Yb-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Jul 2002 22:51:19 -0700
Message-Id: <1027317081.1092.3.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 13:08, Alan Cox wrote:
> Tested and running on my Compaq both in bbuf and direct mode.
> 

I need this to compile, which leads me to believe that perhaps that
wasn't your final patch...

--- linux-2.5.27/drivers/net/tlan.c.~1~	Sun Jul 21 18:20:49 2002
+++ linux-2.5.27/drivers/net/tlan.c	Sun Jul 21 22:40:31 2002
@@ -1536,7 +1536,7 @@
 				new_skb->dev = dev;
 				skb_reserve( new_skb, 2 );
 				t = (void *) skb_put( new_skb, TLAN_MAX_FRAME_SIZE );
-				head_list->buffer[0].address = pci_map_single(priv->pciDev, newskb->data, TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
+				head_list->buffer[0].address = pci_map_single(priv->pciDev, new_skb->data, TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
 				head_list->buffer[8].address = (u32) t;
 #ifdef __LP64__
 #error "Not 64bit clean"

