Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131841AbQLMVcE>; Wed, 13 Dec 2000 16:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131991AbQLMVby>; Wed, 13 Dec 2000 16:31:54 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:22292 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S131841AbQLMVbs>; Wed, 13 Dec 2000 16:31:48 -0500
Date: Wed, 13 Dec 2000 21:59:15 +0100
From: Christian Ullrich <chris@chrullrich.de>
To: linux-kernel@vger.kernel.org
Subject: Re: insmod problem after modutils upgrading
Message-ID: <20001213215915.A10848@christian.chrullrich.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <001b01c0652b$ec758de0$247d9cca@mindef>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <001b01c0652b$ec758de0$247d9cca@mindef>; from csyap@starnet.gov.sg on Thu, Dec 14, 2000 at 01:41:28AM +0800
X-M$-Free-System: since 1999-11-28
X-Current-Uptime: 1 d, 00:33:11 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Corisen schrieb am Donnerstag, 14.12.2000:

> executing "insmod 8139too" at the command prompt shows the following error
> message:
> using /lib/modules/2.4.0-test12/kernel/drivers/net/8139too.o
> /lib/modules/2.4.0-test12/kernel/drivers/net/8139too.o: symbol for
> parameter debug not found.

> how can i make insmod load the network module again pls?

I "fixed" the same problem in 2.2.18 by commenting out the line

MODULE_PARM (debug, "i");

near the end of drivers/net/8139too.c. Since I run modutils 2.3.22
as well, it can't be related to the modutils.

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
