Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKMWYY>; Mon, 13 Nov 2000 17:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129159AbQKMWYP>; Mon, 13 Nov 2000 17:24:15 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:15880 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129061AbQKMWYF>; Mon, 13 Nov 2000 17:24:05 -0500
From: "LA Walsh" <law@sgi.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: IDE0 /dev/hda performance hit in 2217 on my HW
Date: Mon, 13 Nov 2000 13:52:37 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHIEJDCJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I skimmed over the archives and didn't find a mention of this.  I thought
I'd noticed this when I first installed 2217, but I was too busy to verify
it at the time.

Simple case:
Under 2216, I can do a 'badblocks /dev/hda1 XXXXX'.  Vmstat shows about
10,000K/s average.  This is consistent with 'dd' operations I use to copy
partitions for disk mirroring/backup.

Under 2217, the xfer speed drops to near 1,000K/s.  This is for both
'badblocks'
and a 'dd' if=/dev/hda of=/dev/hdb bs=256k.  In both instances, I notice
a near 90% performance degredation.

Haven't tried any latest 2.2.18's -- has there been any work that might
have fixed this problem in 2218.  Am I the only person who noticed this?
I.e. -- maybe it's something peculiar to my HW (Inspiron 7500),
IBM DARA-22.5G HD.



--
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice/Vmail: (650) 933-5338

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
