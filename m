Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131156AbQKWXfT>; Thu, 23 Nov 2000 18:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131118AbQKWXfA>; Thu, 23 Nov 2000 18:35:00 -0500
Received: from faun.nada.kth.se ([130.237.222.80]:37560 "EHLO faun.nada.kth.se")
        by vger.kernel.org with ESMTP id <S131101AbQKWXev>;
        Thu, 23 Nov 2000 18:34:51 -0500
Date: Fri, 24 Nov 2000 00:04:50 +0100 (MET)
Message-Id: <200011232304.AAA12663@faun.nada.kth.se>
From: Roland Orre <orre@nada.kth.se>
To: linux-kernel@vger.kernel.org
Subject: Can't mount SCSI CDROM in 2.4.*
Reply-to: orre@nada.kth.se (Roland Orre)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I started running the 2.4.0-test kernels a couple of months ago
I'm not able to use my scsi cdrom and cdwriter.

Today I installed 2.4.0-test11, still the same problem.

bayes:/dev# ls -l /dev/scd0 
brw-rw----    1 root     cdrom     11,   0 Oct 21 04:53 /dev/scd0

bayes:/dev# mount -t iso9660 /dev/scd0 /cdrom
mount: /dev/scd0 has wrong major or minor number

bayes:/dev# mount -V
mount: mount-2.10o

Each time I want to access the cdrom or cdwriter I have to reboot w 2.2.17
where it works fine.

I've even tried with creating a generic block device
bayes:/dev# ls -l /dev/scg0 
brw-r--r--    1 root     root      21,   0 Nov 23 23:41 /dev/scg0

byes:/dev# mount -t iso9660 /dev/scg0 /cdrom
mount: /dev/scg0 has wrong major or minor number

Apart from this the 2.4.0-test kernels have been running very stable
for me. My systems are dual PII on ASUS PL97-DS and P2B-DS

According to Documentation/devices.txt nothing has changed according
major numbers for these devices from 2.2 to 2.4.

I'm grateful for any hint.

    Best regards
    Roland Orre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
