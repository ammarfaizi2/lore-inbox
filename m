Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSK1Cgo>; Wed, 27 Nov 2002 21:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSK1Cgo>; Wed, 27 Nov 2002 21:36:44 -0500
Received: from mail.michigannet.com ([208.49.116.30]:52744 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S265098AbSK1Cgn>; Wed, 27 Nov 2002 21:36:43 -0500
Date: Wed, 27 Nov 2002 21:43:55 -0500
From: Paul <set@pobox.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: trivial@rustcorp.com.au
Subject: [uPATCH] NCR5380.c compile fix Re: Linux v2.5.50
Message-ID: <20021128024354.GK1432@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	trivial@rustcorp.com.au
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com>, on Wed Nov 27, 2002 [03:07:38 PM] said:
> 
> Taking a small thanksgiving break, but before that here's 2.5.50.
> 

	Hi;

	Needed this so NCR5380.c would compile. (via pas16)

Paul
set@pobox.com

--- 2.5.50.virgin/drivers/scsi/NCR5380.c	2002-11-12 21:18:00.000000000 -0500
+++ 2.5.50/drivers/scsi/NCR5380.c	2002-11-27 21:20:26.000000000 -0500
@@ -1477,8 +1477,8 @@
 	int len;
 	unsigned long timeout;
 	unsigned char value;
-	NCR5380_setup(instance);
 	int err;
+	NCR5380_setup(instance);
 
 	if (hostdata->selecting) {
 		if(instance->irq != IRQ_NONE)
