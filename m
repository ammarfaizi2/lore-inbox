Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUELIzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUELIzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 04:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUELIzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 04:55:39 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:17889 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S264913AbUELIzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 04:55:38 -0400
Date: Wed, 12 May 2004 10:55:37 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Support for VIA PadLock crypto engine
In-Reply-To: <Pine.LNX.4.53.0405111853040.10474@maxipes.logix.cz>
Message-ID: <Pine.LNX.4.53.0405121051580.24118@maxipes.logix.cz>
References: <Xine.LNX.4.44.0405101152550.1943-100000@thoron.boston.redhat.com>
 <Pine.LNX.4.53.0405111853040.10474@maxipes.logix.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone testing/comitting this, please also apply the following patch
on top of the previous ones.

Michal Ludvig

--- linux-2.6.5/crypto/api.c	2004-05-11 14:42:55.000000000 +0200
+++ linux-2.6.5/crypto/api.c	2004-05-12 10:40:15.217391920 +0200
@@ -48,7 +48,7 @@ struct crypto_alg *crypto_alg_lookup(con
 			alg = q;
 	}

-	if (! crypto_alg_get(alg))
+	if (alg && !crypto_alg_get(alg))
 		alg = NULL;

 	up_read(&crypto_alg_sem);
