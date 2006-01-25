Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWAYAZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWAYAZy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWAYAZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:25:54 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:5866 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750895AbWAYAZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:25:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Ig/bb+ElsMIXzszm/+Tw/5CeOPvLEC3LOoq3CH+IGdOMeZIwPZ+miD5fV8yk1chbNu4of+Nc+rWmuhjAlfjnMRsE6Q7OXlbZSxSZY9zCNJ7Z23/QWBcVZ44Q0aswnB86SLUcEwTngplCEQ+Y8OGCLDgd0O57/kcvOLbo4wwaYA4=
Date: Wed, 25 Jan 2006 03:43:32 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] gusclassic: fix adding second dma channel
Message-ID: <20060125004332.GD3234@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 sound/isa/gus/gusclassic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/isa/gus/gusclassic.c
+++ b/sound/isa/gus/gusclassic.c
@@ -195,7 +195,7 @@ static int __init snd_gusclassic_probe(s
 			goto _err;
 	}
 	sprintf(card->longname + strlen(card->longname), " at 0x%lx, irq %d, dma %d", gus->gf1.port, xirq, xdma1);
-	if (dma2 >= 0)
+	if (xdma2 >= 0)
 		sprintf(card->longname + strlen(card->longname), "&%d", xdma2);
 
 	snd_card_set_dev(card, &pdev->dev);

