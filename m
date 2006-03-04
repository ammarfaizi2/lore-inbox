Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751879AbWCDRJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbWCDRJy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWCDRJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:09:54 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:8130 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751879AbWCDRJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:09:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=DNVFwU5um2gBgqbU/qXIQMvK8uNBiN+uA5OOqjOCCnSp7QGZwuQzlCaPvoqk/sLjMeam48BY1OyL57T52DhArNoU9RVgKVLhd/C836Ws5oZxxbINGrmUvPAE1aleRJ5DRtYkDfxyFZ36a+DgMHCc51tiYoC0zSv3ZcyGn+9+ldE=
Date: Sat, 4 Mar 2006 20:09:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Change dash2underscore() return value to char
Message-ID: <20060304170909.GB22058@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>

Since dash2underscore() just operates and returns chars,
I guess its safe to change the return value to a char.
With my .config, this reduces its size by 5 bytes.

   text    data     bss     dec     hex filename
   4155     152       0    4307    10d3 params.o.orig
   4150     152       0    4302    10ce params.o

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/kernel/params.c
+++ b/kernel/params.c
@@ -31,7 +31,7 @@
 #define DEBUGP(fmt, a...)
 #endif
 
-static inline int dash2underscore(char c)
+static inline char dash2underscore(char c)
 {
 	if (c == '-')
 		return '_';

