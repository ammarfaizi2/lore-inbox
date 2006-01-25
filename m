Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWAYAZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWAYAZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWAYAZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:25:11 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:26070 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750892AbWAYAZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:25:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=M+nYidOgz7TDFSmAmF+K/1sVEPjxzzQU/9H3iQfnBmJ+YIurGM43GNdawXBuHAEpv6rMJYa2ZqolBTThevOgbZQ3eQH5BnP8XHVJn82C8ofJTquxTba0cIvF3qipVFk2//XIxK/62lgCJdaDQo2Kfj76SOF166KpI6VAId6wKYY=
Date: Wed, 25 Jan 2006 03:42:49 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: [PATCH] opl3sa2: fix adding second dma channel
Message-ID: <20060125004249.GC3234@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dma2 is a global array. sprintf below suggests there was a typo.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 sound/isa/opl3sa2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -721,7 +721,7 @@ static int __devinit snd_opl3sa2_probe(s
 	}
 	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
 		card->shortname, chip->port, xirq, xdma1);
-	if (dma2 >= 0)
+	if (xdma2 >= 0)
 		sprintf(card->longname + strlen(card->longname), "&%d", xdma2);
 
 	return snd_card_register(card);

