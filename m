Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTEVAY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTEVAY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:24:57 -0400
Received: from dp.samba.org ([66.70.73.150]:24720 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262390AbTEVAY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:24:56 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16076.7126.388420.751765@argo.ozlabs.ibm.com>
Date: Thu, 22 May 2003 10:37:42 +1000
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: <linux-kernel@vger.kernel.org>, <benh@kernel.crashing.org>
Subject: Re: [PATCH] Compile fix for pmac IDE driver
In-Reply-To: <Pine.SOL.4.30.0305191344390.23742-100000@mion.elka.pw.edu.pl>
References: <16072.13753.498811.834748@argo.ozlabs.ibm.com>
	<Pine.SOL.4.30.0305191344390.23742-100000@mion.elka.pw.edu.pl>
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart,

> Thanks Paul.
> 
> I've seen this fix also in hch's pmac compilation fixes patch,
> so I think it will be in Linus' tree soon.

It hasn't got into Linus' tree yet.  Could you send it on to him, or
alternatively do you mind if I send it to him?

Thanks,
Paul.

diff -urN linux-2.5/drivers/ide/ppc/pmac.c pmac-2.5/drivers/ide/ppc/pmac.c
--- linux-2.5/drivers/ide/ppc/pmac.c	2003-05-12 17:41:32.000000000 +1000
+++ pmac-2.5/drivers/ide/ppc/pmac.c	2003-05-13 16:48:42.000000000 +1000
@@ -721,7 +721,7 @@
 		}
 	}

-	return NODEV;
+	return 0;
 }

 void __init
