Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263214AbTDCChp>; Wed, 2 Apr 2003 21:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263239AbTDCChp>; Wed, 2 Apr 2003 21:37:45 -0500
Received: from mail.casabyte.com ([209.63.254.226]:57357 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP
	id <S263214AbTDCCho>; Wed, 2 Apr 2003 21:37:44 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "Hua Zhong" <hzhong@cisco.com>, "Christoph Rohland" <cr@sap.com>,
       "Daniel Egger" <degger@fhm.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Date: Wed, 2 Apr 2003 18:49:02 -0800
Message-ID: <PEEPIDHAKMCGHDBJLHKGKEOLCFAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <CDEDIMAGFBEBKHDJPCLDCECBDGAA.hzhong@cisco.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I presume the below was a typo and In the second mount it should be

"mount -t ext2 -o loop /mnt/tmp/A /mnt/loopback"

instead of just

"mount -t ext2 -o loop /mnt/tmp /mnt/loopback"

Else wise the directory name "/mnt/tmp" would most certainly be a bad target
for a loopback mount.

Rob.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Hua Zhong
Sent: Tuesday, April 01, 2003 11:55 PM
To: Christoph Rohland; Daniel Egger
Cc: linux-kernel@vger.kernel.org
Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 /
2.4.20-pre2)


mount -t tmpfs tmpfs /mnt/tmp
extract file A to /mnt/tmp/A
mount -t ext2 -o loop /mnt/tmp /mnt/loopback

You'll get "ioctl: LOOP_SET_FD: Invalid argument".


