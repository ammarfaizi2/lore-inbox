Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUJSHZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUJSHZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 03:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268159AbUJSHZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 03:25:18 -0400
Received: from hydra.colinet.de ([194.231.113.36]:43667 "EHLO hydra.colinet.de")
	by vger.kernel.org with ESMTP id S268157AbUJSHZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 03:25:09 -0400
Message-Id: <200410190723.i9J7NNuv027374@hydra.colinet.de>
Date: Tue, 19 Oct 2004 09:23:23 +0200 (CEST)
From: "T. Weyergraf" <kirk@colinet.de>
Subject: patch-2.6.9 against 2.6.8.1
To: linux-kernel@vger.kernel.org
cc: kirk@colinet.de
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just build 2.6.9 using the patch-2.6.9, as always. Previously,
I was using 2.6.8.1 and i expected patch-2.6.9 to work on the
2.6.8.1 tree.
The patch-2.6.9 is somewhat "confused". Against 2.6.8.1, it fails
to change the SUBLEVEL field:

<snip>
@@ -1,6 +1,6 @@
 VERSION = 2
 PATCHLEVEL = 6
-SUBLEVEL = 8
+SUBLEVEL = 9
 EXTRAVERSION =
 NAME=Zonked Quokka
</snip>

As one can see, the patch failes, since in 2.6.8.1, EXTRAVERSION is set
to 1. Also, patch-2.6.9 contains the small fixes in fs/nfs/file.c, that
were given in patch-2.6.8.1.

Is this the desired behaviour ? Based on the past, i expected new
patches to go against the latest stable kernel ( which is reported
2.6.8.1 by kernel.org ). Will - in the future - new patches skip the
4-digit kernelpatches ?

I do not intent to start a flamewar over whether 4-digit kernelreleases
are the right/wrong way to go. I am just looking for a consistent
behaviour, which is at this point only given, if you expect new
kernelreleases to go against the last 3-digit release.

Is that so ?

Regards,
Thomas Weyergraf

-- 
Thomas Weyergraf                                     kirk@colinet.de
Funny IA64 Opcode Dept: ( see arch/ia64/lib/memset.S )
"br.ret.spnt.few" - got back from getting beer, did not spend a lot.

