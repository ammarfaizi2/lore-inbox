Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbREXNAv>; Thu, 24 May 2001 09:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbREXNAl>; Thu, 24 May 2001 09:00:41 -0400
Received: from picard.csihq.com ([204.17.222.1]:61577 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S261861AbREXNA2>;
	Thu, 24 May 2001 09:00:28 -0400
Message-ID: <030d01c0e451$a3680100$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: 2..4.5-pre5 bad fsck
Date: Thu, 24 May 2001 09:01:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.2 works fine.
2.4.5-pre5 won't get past fsck of /dev/md0 -- locks up towards the end.  I'm
running the same kernel on two other machine (different motherboards though)
I'm using gcc-3.0 and glibc-2.2.3

/dev/md0 is a dual-IDE RAID1 (2nd drive is currently disabled)
md0 : active raid1 hda1[0]
      39082560 blocks [2/1] [U_]

Under 2.4.2 boot fsck ends
/dev/md0 was not cleanly unmounted, check forced.
/dev/md0: x/x files (x% non-contiguous), x/x blocks

But under 2.4.5-pre5 it doesn't get past the first "check forced" message.
It just locks up completely after it runs for a couple of minutes.

Motherboard is SuperMicro 370dl3
Disk WDC WD400BB-00AUA1
PCI Info:
00:00.0 Host bridge: Relience Computer CNB20HE (rev 05)
00:00.1 Host bridge: Relience Computer CNB20HE (rev 05)
00:0f.1 IDE interface: Relience Computer: Unknown device 0211


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

