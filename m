Return-Path: <linux-kernel-owner+w=401wt.eu-S964845AbXASSzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbXASSzP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932842AbXASSzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:55:15 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:26693 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932841AbXASSzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:55:13 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NBmTKd4stY/j/2f9Sx7fnsxqJgTGt/QCkeb+3GJrsLYLh7O6geyNhPz1TI9i1UL+rqfWN0azPuN7K1DTAeGner2B4xLyG03Z6pTsiZ6ImCecYxlNIdqF9CyI+cI5iWACsNDlWgwghJ9udSf4Qx6WfGuFXTKfSQWvd/q0YFKP4Ck=
Message-ID: <bc5b4c660701191055y584edfc7j195933a94c5f1eda@mail.gmail.com>
Date: Fri, 19 Jan 2007 18:55:10 +0000
From: "Marco Ferra" <mferra@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Odd USB problem on THOMSON PDP95FM
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel developers

I don't know if this is the proper list but I have a very odd problem
and it's driving me nuts for the past two days.

I have a portable mp3 player named:

usb-storage: waiting for device to settle before scanning
  Vendor: THOMSON   Model: PDP95FM Series    Rev: 0100
  Type:   Direct-Access                      ANSI SCSI revision: 04
usb-storage: device scan complete
SCSI device sda: 244288 2048-byte hdwr sectors (500 MB)
sda: Write Protect is off
sda: Mode Sense: 3e 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 244288 2048-byte hdwr sectors (500 MB)
sda: Write Protect is off
sda: Mode Sense: 3e 00 00 00
sda: assuming drive cache: write through
 sda: unknown partition table
sd 0:0:0:0: Attached scsi removable disk sda

that, I think, should act like an USB mass storage disk.  I have done:

# dd if=/dev/sda of=/dev/sda.dump

sucessfully, several times.  But I can't do:

# dd if=/dev/zero of=/dev/sda

The error, all the time:

usb 2-1: reset full speed USB device using uhci_hcd and address 3
usb 2-1: reset full speed USB device using uhci_hcd and address 3
usb 2-1: reset full speed USB device using uhci_hcd and address 3
usb 2-1: reset full speed USB device using uhci_hcd and address 3
usb 2-1: reset full speed USB device using uhci_hcd and address 3
usb 2-1: reset full speed USB device using uhci_hcd and address 3
sd 0:0:0:0: SCSI error: return code = 0x50000
end_request: I/O error, dev sda, sector 1064
Buffer I/O error on device sda, logical block 133
lost page write due to I/O error on sda

and from dd:

bash-3.00# dd if=/dev/zero of=/dev/sda
dd: writing to `/dev/sda': Input/output error
13489+0 records in
13488+0 records out
6905856 bytes (6.9 MB) copied, 206.473 seconds, 33.4 kB/s
dd: closing input file `/dev/zero': Bad file descriptor

It never stops on the same place, but is always before reaching the
7 MB.  I thought that I could ajust some tuneable parameters here:

/sys/block/sda/device

But I'm completly lost on the problem.  If anyone could be of assistance,
it would appreciated.

Sincere regards
Marco
