Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129619AbQKBWQp>; Thu, 2 Nov 2000 17:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQKBWQe>; Thu, 2 Nov 2000 17:16:34 -0500
Received: from 209-164-222-32.iglobal.net ([209.164.222.32]:32643 "EHLO
	liu.fafner.com") by vger.kernel.org with ESMTP id <S129619AbQKBWQT>;
	Thu, 2 Nov 2000 17:16:19 -0500
From: Elizabeth Morris-Baker <eamb@liu.fafner.com>
Message-Id: <200011022158.PAA08240@liu.fafner.com>
Subject: Re: scsi init problem in 2.4.0-test10?
To: chen_xiangping@emc.com (chen, xiangping)
Date: Thu, 2 Nov 2000 15:58:24 -0600 (CST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD979DF6@elway.lss.emc.com> from "chen, xiangping" at Nov 02, 2000 04:49:11 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hello,

	Yes, I encountered the same problem, and have a fix, but
	want to test it. If the author of scsi_scan.c would like
	to correct it, then that would be fine.

	Basically the problem is in scan_scsis_single.
	Some scsi devices are notoriously brain dead
	about answering inquiries without having 
	recived a TUR and then spinning up.
	The problem seems to be the disk, not the controller,
	if this is the same problem.

	The problem appeared in the test kernels because
	the TUR *used* to be there, now it is not.

	Hope this helps.

	Just curious, what kind of scsi disk do you have??
	lemme guess... Compaq Atlas?? :>

	cheers, 

	Elizabeth

> 
> I met a problem when trying to upgrade my Linux kernel to 2.4.0-test10.
> The machine is Compay AP550, dual processor, mem 512 MB, and 863 MHZ freq.
> It has two scsi host adaptors. one is AIC-7892 ultra 160/m connected to 
> internal hard disk, and the other is AHA-3944 ultra scsi connected to 
> an attached disk. The boot process stops after detection of the first
> scsi host, error info is:
> 	scsi: aborting command due to time out: pid0, scsci1, channel 0, 
> 	id 0, lun 0, Inquiry 00 00 00 ff 00
> 
> Previous OS on this machine was RedHat 6.2 kernel version 2.2.14
> 
> looking forward to your help!
> 
> Xiangping
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
