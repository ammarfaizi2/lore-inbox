Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLMFuc>; Wed, 13 Dec 2000 00:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131049AbQLMFuW>; Wed, 13 Dec 2000 00:50:22 -0500
Received: from [203.25.188.10] ([203.25.188.10]:23434 "EHLO
	whitsun.whitsunday.net.au") by vger.kernel.org with ESMTP
	id <S129387AbQLMFuR>; Wed, 13 Dec 2000 00:50:17 -0500
Message-ID: <000001c064c4$44c1e7e0$67bc19cb@default>
From: "John Fort" <johnf@whitsunday.net.au>
To: <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <johnf@whitsunday.net.au>
Subject: 17 month late patch for Linux v2.2.x
Date: Wed, 13 Dec 2000 15:18:19 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, this is identical to the patch that was in patch-2.3.10 of Jul 5 1999
except a line number difference of one.

It is only needed if you build your v2.2.x kernel for the Initio 1060p LVD
SCSI controller using a later compiler
than 2.7.2.3 and then are stupid enough to ignore any compiler warnings
about 'ambiguous else, suggest using braces'.

Harbison & Steele 2nd Ed, p202, under 'Dangling Else problem' also show the
misleading indentation.

This aggravation was prompted by trying to install RedHat 7.0 and Mandrake
7.2 to my SCSI disks last week.

In linux/drivers/scsi/i60uscsi.c:
Line 768:  add  ' {' at end of line
Line 771: replace 4th Tab with '} '
Line 772: delete 5th Tab.

I tried hand entering the patch into Outhouse Exploder 5.5 and conceeded.

cu  johnf


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
