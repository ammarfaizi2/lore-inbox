Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130510AbRAPPyC>; Tue, 16 Jan 2001 10:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRAPPxn>; Tue, 16 Jan 2001 10:53:43 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:10250 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S130454AbRAPPxf>; Tue, 16 Jan 2001 10:53:35 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 10:49:05 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have one issue which requires fix from the linux kernel. 
Initially i put a SCSI controller and install the OS on the drive connected
to it. After installing the OS (on sda), the customer puts another SCSI
controller. The BIOS for the first controller has BIOS enabled and for the
second controller does not have the BIOS enabled. 

The linux loads the driver for the second controller first and assigns sda
to it first , and the actual boot drive gets some sdX device node. 
>From the lilo prompt we can override it with root=/dev/sdX to boot to the
correct drive and controller, but for a end -user using these cards, this is
no fun.


Can the linux kernel be changed in such a way that kernel will look for the
actual boot drive and re-order the drives so that mounting can go on in the
right order.

we need some kind of signature being written in the drive, which the kernel
will use for determining the boot drive and later re-order drives, if
required.

Is someone handling this already? 

TIA


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
