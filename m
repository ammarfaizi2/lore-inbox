Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277919AbRJITQm>; Tue, 9 Oct 2001 15:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277918AbRJITQc>; Tue, 9 Oct 2001 15:16:32 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:4881 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S277916AbRJITQQ>; Tue, 9 Oct 2001 15:16:16 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F5507929B@srgraham.eng.emc.com>
From: "conway, heather" <conway_heather@emc.com>
To: "'Andre Margis '" <andre@sam.com.br>,
        "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>
Subject: RE: EMC SYMMETRIX multiple LUN's
Date: Tue, 9 Oct 2001 15:16:20 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,
There is a problem in the SCSI scanning code in v2.4.7 and up.  As of right
now, I have not found a patch or fix that will work to correct the problem
of scanning properly with or without the Symmetrix.  In v2.4.7, the SCSI
scanning code was changed.  That coupled with the fact that sequentail
scanning is used instead of a REPORT_LUNs and the fact that the SCSI
midlayer will scan indefinitely for LUNs can cause a panic or can cause the
host to scan indefinitely.
There have been a couple of patches posted, but none have fixed the problem
yet.  
Heather 

-----Original Message-----
From: Andre Margis
To: linux-kernel@vger.kernel.org
Sent: 10/8/01 9:50 AM
Subject: EMC SYMMETRIX multiple LUN's

I testing DELL 8450 under Linux, and kernel probe only two LUN's from
EMC, 0 
and 1, but I have 2 and 254, if  I use scsi add-single-device to this
other 
LUN's, works perfect. I try to set max_scsi_luns, has the same results.

I test with kernel 2.4.9, 2.4.10-ac7, both have the same problem.

With Conectiva Linux Kernel 2.4.5-9cl, he show all LUNS, work fine!

Any Help?


Thank's




Andre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
