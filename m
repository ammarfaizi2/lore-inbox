Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280790AbRK1WAu>; Wed, 28 Nov 2001 17:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280803AbRK1WAj>; Wed, 28 Nov 2001 17:00:39 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:38607 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S280790AbRK1WA0>;
	Wed, 28 Nov 2001 17:00:26 -0500
Date: Wed, 28 Nov 2001 23:00:23 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200111282200.XAA02802@harpo.it.uu.se>
To: marcelo@conectiva.com.br
Subject: Re: Linux 2.4.17-pre1
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2001 13:47:07 -0200 (BRST), Marcelo Tosatti wrote:
>pre1:
>
>- Added missing MODULE_LICENSE("GPL") in some   (Andreas Krennmair)
>  modules

Below is yet another one, for ide-tape.c; please apply.

The files in fs/nls/ that have license tags (nls_iso8859-1.c lacks one),
use "BSD without advertising clause", which causes the kernel to be
tainted. Shouldn't fs/nls/*.c use "Dual BSD/GPL" or "GPL" instead?

/Mikael

--- linux-2.4.17-pre1/drivers/ide/ide-tape.c.~1~	Thu Aug 16 23:47:01 2001
+++ linux-2.4.17-pre1/drivers/ide/ide-tape.c	Wed Nov 28 20:34:07 2001
@@ -6182,6 +6182,7 @@
 };
 
 MODULE_DESCRIPTION("ATAPI Streaming TAPE Driver");
+MODULE_LICENSE("GPL");
 
 static void __exit idetape_exit (void)
 {
