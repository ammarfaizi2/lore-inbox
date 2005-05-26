Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVEZPjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVEZPjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 11:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVEZPjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 11:39:40 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:24295 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S261569AbVEZPjh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 11:39:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: IDE DMA with SATA, 2.6 kernels
Date: Thu, 26 May 2005 08:40:08 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C31B4EB9@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IDE DMA with SATA, 2.6 kernels
Thread-Index: AcVhqGOZRF8X8TnoTq2VqZ/zZ8CmEgAYAxOw
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Tyler Eaves" <tyler@cg2.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 May 2005 15:39:37.0039 (UTC) FILETIME=[1F5DB5F0:01C56209]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Disk Setup:
>
>/dev/sda is a 200GB Maxtor SATA drive containing /boot,/, and swap
>/dev/hda is a DVD-ROM/CD-RW driver (IDE)
>/dev/hdc is a 160GB Maxtor IDE drive containing ThatOtherOS(TM)
>
>The SATA drive works superbly, in UDMA133 mode. No complaints there.
>However, it appears that the generic IDE driver grabs the IDE drives
>before the Via driver can get them. This prevents me from using DMA on
>those drivers, so, for instance, ripping CDs is really painful. I can
>rip at about 2x on a good day, versus 40x+ ripping in Exact Audio Copy
>under XP.
>
>You can find the relevant portion of my dmesg (and hdparm) at
>http://cg2.org/dmesg.txt
>
>Any assistance would be very much appreciated.

 Do you have .config handy? Make shure you've got
CONFIG_BLK_DEV_IDEDMA_PCI
enabled there. In most cases you should be able to control DMA with
generic
driver.
 Another thing to double check is that DMA is on in your BIOS.

Aleks. 
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
