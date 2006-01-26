Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWAZCJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWAZCJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 21:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWAZCJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 21:09:30 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:56335 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751264AbWAZCJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 21:09:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=BSA1bibx82hjXBETCpCGSZ1LcAViq6NGgZBl+GEBHIvBdO06Fn/uYINEQfRvqkrMANYh8onDGPJw6U9kw82M3C9bPrRZIQvcaUUyshsOkPF8PIWQJRyKpUgtjOiZBxF8UmjZ3LVlO7KVKI9j4PeZ23tPtivlG2xPV44+cQ/MVWc=
Date: Thu, 26 Jan 2006 05:27:14 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [PATCH] at76c651: don't do generic __ilog2 on mips
Message-ID: <20060126022714.GB6577@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix

dvb/frontends/at76c651.c: redifinition of __ilog2 blah blah

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/media/dvb/frontends/at76c651.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb/frontends/at76c651.c
+++ b/drivers/media/dvb/frontends/at76c651.c
@@ -61,7 +61,7 @@ static int debug;
 	} while (0)
 
 
-#if ! defined(__powerpc__)
+#if ! defined(__powerpc__) && ! defined(__mips__)
 static __inline__ int __ilog2(unsigned long x)
 {
 	int i;

