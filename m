Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276030AbRI1Mdu>; Fri, 28 Sep 2001 08:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276031AbRI1Mdk>; Fri, 28 Sep 2001 08:33:40 -0400
Received: from gateway.advanced-unibyte.de ([213.69.4.70]:53332 "EHLO
	nt3.au.de") by vger.kernel.org with ESMTP id <S276030AbRI1MdW> convert rfc822-to-8bit;
	Fri, 28 Sep 2001 08:33:22 -0400
Content-Class: urn:content-classes:message
Subject: Problems with LVM and "scsi add-single-device"
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 28 Sep 2001 14:33:54 +0200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <A0D931F9C43F0941A4AF334EBF2E2B16012ED3@nt3.au.de>
X-MS-TNEF-Correlator: <A0D931F9C43F0941A4AF334EBF2E2B16012ED3@nt3.au.de>
Thread-Topic: Problems with LVM and "scsi add-single-device"
thread-index: AcFIGdW6Dj60v02yQ6y5as/Wcl3luQ==
From: "Michael Dr|ing" <Michael.Drueing@advanced-unibyte.de>
To: "Linux Kernel Mailing List \(E-Mail\)" <linux-kernel@vger.kernel.org>
Cc: "Alexander Landgraf" <Alexander.Landgraf@advanced-unibyte.de>
X-OriginalArrivalTime: 28 Sep 2001 12:33:55.0406 (UTC) FILETIME=[D68D6EE0:01C14819]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we're having problems using LVM (see end of mail for version numbers) together with the "scsi add-single-device"-feature:
We have an external RAID which responds on three SCSI-LUN's: ID 2, LUN 0 to 2. On LUNs 0 and 1 we have created PVs and mapped them into one LV. Now we wanted to extend our filesystem (XFS) on the third LUN without bringing the system down.
We did an "echo scsi add-single-device 2 0 2 2 > /proc/scsi/scsi" to make the kernel recognize the new LUN. But after that all calls to "pvscan" or "pvcreate" or even "vgscan" failed. They slow down the system extremely and we have to interrupt them with Ctrl-C.
Anyone got an idea what the problem might be?

Thanks
--Michael

Here are some version numbers of our system:
Linux 2.4.10 (base system is SuSE 7.1 with SGI XFS kernel built from CVS-tree)
LVM 0.9.1 beta 6 (however, the user programs [pvscan, pvcreate, ...] are from beta 7)
aic7xxx driver 6.2.1 (that's our SCSI adapter)
