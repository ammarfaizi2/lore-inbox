Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135625AbRDSLdc>; Thu, 19 Apr 2001 07:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135626AbRDSLdW>; Thu, 19 Apr 2001 07:33:22 -0400
Received: from quechua.inka.de ([212.227.14.2]:29454 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S135625AbRDSLdO>;
	Thu, 19 Apr 2001 07:33:14 -0400
To: linux-kernel@vger.kernel.org
Subject: SCSI tape test results
Organization: private Linux site, southern Germany
Date: Thu, 19 Apr 2001 13:10:53 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14qCKs-0008NQ-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested my systems to try to reproduce the recently reported SCSI
tape corruptions. I did not find any errors, the tape works OK.

Linux version 2.4.3 (olaf@bigred) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Sat Mar 31 11:51:54 CEST 2001
K6-III-400, 96MB
NCR53C815 SCSI controller
HP C1533A DDS-2 tape drive
Tape drive compression turned off

These were the tests:
1. Copied (with "cp") and verified (with "cmp") two 650MB CD images
   from an NFS server.
2. In a  directory on an IDE disk:
   tar cSvf /dev/tape .
   tar df /dev/tape .
3. On the same disk, ~6.5GB directory:
   tar cSf - . | tarmill -F1500 -m8M -C6M zip 3 list >/dev/tape
   tarmill -m8M -C6M unzip  </dev/tape | tar df -
   (tarmill is a tar archive compression/encryption program, available
   from <URL:http://sites.inka.de/~bigred/sw/>. It reads/writes in
   blocks the same size as tar, just in case this is relevant.)

Still have to test copying from a SCSI disk on the same bus as the
tape drive.

Olaf
