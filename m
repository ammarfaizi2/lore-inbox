Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTJONJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTJONJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:09:33 -0400
Received: from webmail.broadbus.com ([12.25.43.7]:9867 "EHLO
	btiexch01.broadbus.com") by vger.kernel.org with ESMTP
	id S263128AbTJONJQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:09:16 -0400
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: normal
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: USB mass storage device - jumpdrive 2.0 pro - linux driver
Date: Wed, 15 Oct 2003 09:09:14 -0400
Message-ID: <3B83C5E7EAB53F44A16CDFB70F9E4BF30CCB41@btiexch01.broadbus.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: USB mass storage device - jumpdrive 2.0 pro - linux driver
thread-index: AcOSq726k5p5wzzARDeywWJflCzA+AAbX/Qg
From: "Chandra Konakalla" <chandrak@broadbus.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg, 

Thanks for the response.

No I do not have sd module in the /dev

I have the following ...

root@10.0.0.147:/dev# ls
console     kmem        mtd4        mtdblock3   ram12       spi
fpga        lcd         mtd5        mtdblock4   ram13       tty
fpga0       loop0       mtd6        mtdblock5   ram14       tty0
fpga1       loop1       mtd7        mtdblock6   ram15       tty1
gpio        mem         mtd8        mtdblock7   ram16       tty2
gpio0       mtd0        mtd9        mtdblock8   ram2        tty3
i2c-0       mtd1        mtdblock0   mtdblock9   ram3        tty4
i2c-1       mtd10       mtdblock1   null        ram4        ttyS0
i2c-2       mtd11       mtdblock10  port        ram5        ttyS1
i2c-3       mtd12       mtdblock11  ptmx        ram6        urandom
i2c-4       mtd13       mtdblock12  pts         ram7        zero
i2c-5       mtd14       mtdblock13  ram0        ram8
i2c-6       mtd15       mtdblock14  ram1        ram9
i2c-7       mtd2        mtdblock15  ram10       random
initctl     mtd3        mtdblock2   ram11       rtc


root@10.0.0.147:~# dmesg
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0xa R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_CAPACITY (10 bytes)
usb-storage: 25 00 00 00 00 00 00 00 00 00 00 00
usb-storage: Bulk command S 0x43425355 T 0xb Trg 0 LUN 0 L 134217728 F
128 CL 10
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 8/8
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0xb R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sda: 503808 512-byte hdwr sectors (258 MB)
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE (6 bytes)
usb-storage: 1a 00 3f 00 ff 00 00 00 00 00 00 00
usb-storage: Bulk command S 0x43425355 T 0xc Trg 0 LUN 0 L -16777216 F
128 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 108/255
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: clearing endpoint halt for pipe 0xc0008280
usb-storage: usb_stor_clear_halt: result=0
usb-storage: Attempting to get CSW (2nd try)...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0xc R -1828716544 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
sda: Write Protect is off
Partition check:
 sda:<7>usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage: 28 00 00 00 00 00 00 00 08 00 00 00
usb-storage: Bulk command S 0x43425355 T 0xd Trg 0 LUN 0 L 1048576 F 128
CL 10
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 4096 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 4096/4096
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0xd R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
 sda1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
usb.c: usb-storage driver claimed interface dcba84c0
hub.c: port 1, portstatus 103, change 0, 12 Mb/s


As I have mentioned in my previous mail shell have to have the end
device driver i.e driver for the jumpdrive 2.0 device ??? Is it the
reason why I am not have the sda in /dev ?? Please let me know if need
to send more info...



Thanks for your help in advance.

Thanks
Chandrasekhar Konakalla




-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Tuesday, October 14, 2003 7:22 PM
To: Chandra Konakalla
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mass storage device - jumpdrive 2.0 pro - linux driver

On Tue, Oct 14, 2003 at 05:51:38PM -0400, Chandra Konakalla wrote:
> Hello 
> 
> I am using the above Lexar made jumpdrive 2.0 pro mass storage device
> with my Host controller ISP 1161A. 
> 
> We are using Linux 2.4.21 with powePC environment.  Following are the
> console output results for different commands.

Do you have the sd module loaded?

thanks,

greg k-h
 
--------------------------------------------------------

 
This email message and any files transmitted with it contain confidential information intended only for the person(s) to whom this email message is addressed.  If you have received this email message in error, please notify the sender immediately by telephone or email and destroy the original message without making a copy.  Thank you. 
 
