Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276050AbRI1NkC>; Fri, 28 Sep 2001 09:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276052AbRI1Njy>; Fri, 28 Sep 2001 09:39:54 -0400
Received: from gateway.advanced-unibyte.de ([213.69.4.70]:39256 "EHLO
	nt3.au.de") by vger.kernel.org with ESMTP id <S276050AbRI1Njn> convert rfc822-to-8bit;
	Fri, 28 Sep 2001 09:39:43 -0400
Content-Class: urn:content-classes:message
Subject: AW: Problems with LVM and "scsi add-single-device"
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
Date: Fri, 28 Sep 2001 15:40:14 +0200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <A0D931F9C43F0941A4AF334EBF2E2B1605169E@nt3.au.de>
X-MS-TNEF-Correlator: <A0D931F9C43F0941A4AF334EBF2E2B1605169E@nt3.au.de>
Thread-Topic: Problems with LVM and "scsi add-single-device"
thread-index: AcFIGdW6Dj60v02yQ6y5as/Wcl3luQACRP8A
From: "Michael Dr|ing" <Michael.Drueing@advanced-unibyte.de>
To: "Michael Dr|ing" <Michael.Drueing@advanced-unibyte.de>,
        "Linux Kernel Mailing List \(E-Mail\)" <linux-kernel@vger.kernel.org>
Cc: "Alexander Landgraf" <Alexander.Landgraf@advanced-unibyte.de>
X-OriginalArrivalTime: 28 Sep 2001 13:40:17.0074 (UTC) FILETIME=[1BCFC120:01C14823]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem was fixed by applying the patch for "/proc/partitions endless loop" posted on the kernel mailing list.
Hope this patch will be in the next kernel-release...

--Michael

> -----Ursprüngliche Nachricht-----
> Von: Michael Drüing 
> Gesendet: Freitag, 28. September 2001 14:34
> An: Linux Kernel Mailing List (E-Mail)
> Cc: Alexander Landgraf
> Betreff: Problems with LVM and "scsi add-single-device"
> 
> 
> Hi,
> 
> we're having problems using LVM (see end of mail for version 
> numbers) together with the "scsi add-single-device"-feature:
> We have an external RAID which responds on three SCSI-LUN's: 
> ID 2, LUN 0 to 2. On LUNs 0 and 1 we have created PVs and 
> mapped them into one LV. Now we wanted to extend our 
> filesystem (XFS) on the third LUN without bringing the system down.
> We did an "echo scsi add-single-device 2 0 2 2 > 
> /proc/scsi/scsi" to make the kernel recognize the new LUN. 
> But after that all calls to "pvscan" or "pvcreate" or even 
> "vgscan" failed. They slow down the system extremely and we 
> have to interrupt them with Ctrl-C.
> Anyone got an idea what the problem might be?
> 
> Thanks
> --Michael
> 
> Here are some version numbers of our system:
> Linux 2.4.10 (base system is SuSE 7.1 with SGI XFS kernel 
> built from CVS-tree)
> LVM 0.9.1 beta 6 (however, the user programs [pvscan, 
> pvcreate, ...] are from beta 7)
> aic7xxx driver 6.2.1 (that's our SCSI adapter)
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
