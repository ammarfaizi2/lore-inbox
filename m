Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129426AbQKBXbG>; Thu, 2 Nov 2000 18:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbQKBXaz>; Thu, 2 Nov 2000 18:30:55 -0500
Received: from mercury.eng.emc.com ([168.159.40.77]:4881 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S129426AbQKBXar>; Thu, 2 Nov 2000 18:30:47 -0500
Message-ID: <276737EB1EC5D311AB950090273BEFDD979DF7@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Elizabeth Morris-Baker'" <eamb@liu.fafner.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: scsi init problem in 2.4.0-test10?
Date: Thu, 2 Nov 2000 18:24:52 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for replying. What bothers me is that it works
in another pc with the same setup to the external disk,
but different internal scsi adaptor. So I did not think
it was the kernel software caused the problem. Any other
guess?

Thanks,

Xiangping




-----Original Message-----
From: Elizabeth Morris-Baker [mailto:eamb@liu.fafner.com]
Sent: Thursday, November 02, 2000 4:58 PM
To: chen_xiangping@emc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: scsi init problem in 2.4.0-test10?


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
