Return-Path: <linux-kernel-owner+w=401wt.eu-S965280AbXATPaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbXATPaY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 10:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbXATPaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 10:30:24 -0500
Received: from stz-bg.com ([213.169.37.103]:40187 "EHLO stz-bg.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965280AbXATPaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 10:30:23 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=stz-bg.com;
  b=YiPF6Si6hsNo10izBovwaH62o2x6SB2hZSLSrqx/dNIf+l46cqiJrMetFLQ9lOgh3DwumoXaIE8c3z9UQDoa7sEZvEZY1+u3pizNckRHUygqnZfsnGlSP4kYcO0K2jgg  ;
Message-ID: <2923.83.228.43.37.1169307020.squirrel@mail.stz-bg.com>
In-Reply-To: <87ps9bro6s.fsf@duaron.myhome.or.jp>
References: <48247.82.103.71.18.1169112129.squirrel@mail.stz-bg.com>
    <1169123236.12968.6.camel@localhost>
    <31333.83.228.43.37.1169131305.squirrel@mail.stz-bg.com>
    <87bqkwv0dg.fsf@duaron.myhome.or.jp>
    <37910.82.103.71.18.1169209969.squirrel@mail.stz-bg.com>
    <87ps9bro6s.fsf@duaron.myhome.or.jp>
Date: Sat, 20 Jan 2007 17:30:20 +0200 (EET)
Subject: Re: PROBLEM: writting files > 100 MB in FAT32
From: "Condor" <condor@stz-bg.com>
To: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Cc: "Kasper Sandberg" <lkml@metanurb.dk>, linux-kernel@vger.kernel.org
Reply-To: condor@stz-bg.com
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "Condor" <condor@stz-bg.com> writes:
>
>>>From debug log:
>> Jan 16 14:56:13 elrond kernel: usb-storage: device found at 4
>> Jan 16 14:56:13 elrond kernel: usb-storage: waiting for device to settle
>> before scanning
>> Jan 16 14:56:18 elrond kernel: sda: Mode Sense: 00 00 00 00
>> Jan 16 14:56:18 elrond kernel: sda: Mode Sense: 00 00 00 00
>> Jan 16 14:56:18 elrond kernel: usb-storage: device scan complete
>>
>>>From syslog:
>> Jan 16 14:56:18 elrond kernel: sda: assuming drive cache: write through
>> Jan 16 14:56:40 elrond kernel: FAT: Filesystem panic (dev sda1)
>> Jan 16 14:56:40 elrond kernel:     invalid access to FAT (entry
>> 0x0fffcf03)
>> Jan 16 14:56:40 elrond kernel:     File system has been set read-only
>
> The disk seems flash disk, and this entry may be on the middle of
> erasing block. The flash disk might be unplugged before flushing dirty
> buffer to disk.  But, it's just my guess.
>

I don't know. I every time mount, copy, sync, unmount and every time files
larges 100 MB that i copy/move to flash is broken. Today i return this
flash to storage and i get new 8 GB, i make exacts test and every things
is work. This problem does not exist, but i tested in my home PC that is
new not in my office in my old laptop. I think that may be flash stick
have some problems or my laptop to work with USB 2.0. But i can guest
only. So i report that the problem is may be not a problem :)

>> Here are from message log:
>>
>> an 16 14:13:55 elrond kernel: usb 2-1: new full speed USB device using
>> uhci_hcd and address 3
>> Jan 16 14:13:55 elrond kernel: usb 2-1: configuration #1 chosen from 1
>> choice
>> Jan 16 14:13:56 elrond kernel: Initializing USB Mass Storage driver...
>> Jan 16 14:13:56 elrond kernel: scsi0 : SCSI emulation for USB Mass
>> Storage
>> devices
>> Jan 16 14:13:56 elrond kernel: usbcore: registered new interface driver
>> usb-storage
>> Jan 16 14:13:56 elrond kernel: USB Mass Storage support registered.
>> Jan 16 14:14:01 elrond kernel: scsi 0:0:0:0: Direct-Access     USB 2.0
>> Flash Disk       0.00 PQ: 0 ANSI: 2
>> Jan 16 14:14:01 elrond kernel: SCSI device sda: 8060927 512-byte hdwr
>> sectors (4127 MB)
>> Jan 16 14:14:01 elrond kernel: sda: Write Protect is off
>> Jan 16 14:14:01 elrond kernel: SCSI device sda: 8060927 512-byte hdwr
>> sectors (4127 MB)
>> Jan 16 14:14:01 elrond kernel: sda: Write Protect is off
>> Jan 16 14:14:01 elrond kernel:  sda: sda1 sda2
>> Jan 16 14:14:01 elrond kernel: sd 0:0:0:0: Attached scsi removable disk
>> sda
>> Jan 16 14:14:01 elrond kernel: sd 0:0:0:0: Attached scsi generic sg0
>> type 0
>> Jan 16 14:28:22 elrond -- MARK --
>> Jan 16 14:37:52 elrond kernel: usb 2-1: USB disconnect, address 3
>> Jan 16 14:48:22 elrond -- MARK --
>> Jan 16 14:56:13 elrond kernel: usb 2-1: new full speed USB device using
>> uhci_hcd and address 4
>> Jan 16 14:56:13 elrond kernel: usb 2-1: configuration #1 chosen from 1
>> choice
>> Jan 16 14:56:13 elrond kernel: scsi1 : SCSI emulation for USB Mass
>> Storage
>> devices
>> Jan 16 14:56:18 elrond kernel: scsi 1:0:0:0: Direct-Access     USB 2.0
>> Flash Disk       0.00 PQ: 0 ANSI: 2
>> Jan 16 14:56:18 elrond kernel: SCSI device sda: 8060927 512-byte hdwr
>> sectors (4127 MB)
>> Jan 16 14:56:18 elrond kernel: sda: Write Protect is off
>> Jan 16 14:56:18 elrond kernel: SCSI device sda: 8060927 512-byte hdwr
>> sectors (4127 MB)
>> Jan 16 14:56:18 elrond kernel: sda: Write Protect is off
>> Jan 16 14:56:18 elrond kernel:  sda: sda1 sda2
>> Jan 16 14:56:18 elrond kernel: sd 1:0:0:0: Attached scsi removable disk
>> sda
>> Jan 16 14:56:18 elrond kernel: sd 1:0:0:0: Attached scsi generic sg0
>> type 0
>> Jan 16 14:58:14 elrond kernel: usb 2-1: USB disconnect, address 4
>> Jan 16 14:59:48 elrond /usr/sbin/gpm[1216]: *** info [mice.c(1766)]:
>> Jan 16 14:59:48 elrond /usr/sbin/gpm[1216]: imps2: Auto-detected
>> intellimouse PS/2
>> Jan 16 15:28:22 elrond -- MARK --
>> Jan 16 15:32:04 elrond kernel: usb 2-1: new full speed USB device using
>> uhci_hcd and address 5
>> Jan 16 15:32:04 elrond kernel: usb 2-1: configuration #1 chosen from 1
>> choice
>> Jan 16 15:32:04 elrond kernel: scsi2 : SCSI emulation for USB Mass
>> Storage
>> devices
>> Jan 16 15:32:09 elrond kernel: scsi 2:0:0:0: Direct-Access     USB 2.0
>> Flash Disk       0.00 PQ: 0 ANSI: 2
>> Jan 16 15:32:09 elrond kernel: SCSI device sda: 8060927 512-byte hdwr
>> sectors (4127 MB)
>> Jan 16 15:32:09 elrond kernel: sda: Write Protect is off
>> Jan 16 15:32:09 elrond kernel: SCSI device sda: 8060927 512-byte hdwr
>> sectors (4127 MB)
>> Jan 16 15:32:09 elrond kernel: sda: Write Protect is off
>> Jan 16 15:32:09 elrond kernel:  sda: sda1 sda2
>> Jan 16 15:32:09 elrond kernel: sd 2:0:0:0: Attached scsi removable disk
>> sda
>> Jan 16 15:32:09 elrond kernel: sd 2:0:0:0: Attached scsi generic sg0
>> type 0
>> Jan 16 15:39:16 elrond kernel: usb 2-1: reset full speed USB device
>> using
>> uhci_hcd and address 5
>> Jan 16 15:50:24 elrond kernel: usb 2-1: USB disconnect, address 5
>>
>>
>> These are the logs that i have. I hope that this can help you.
>>
>> Regards,
>> Condor
>>
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>


Regards,
Condor

