Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266280AbRGFIPo>; Fri, 6 Jul 2001 04:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266282AbRGFIPe>; Fri, 6 Jul 2001 04:15:34 -0400
Received: from dag.newtech.fi ([195.163.186.138]:34513 "HELO dag.newtech.fi")
	by vger.kernel.org with SMTP id <S266280AbRGFIPU> convert rfc822-to-8bit;
	Fri, 6 Jul 2001 04:15:20 -0400
Message-ID: <20010706081504.24274.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-0.27
To: linux-kernel@vger.kernel.org
cc: dag@newtech.fi
Subject: Canon Powershot G1 and USB
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Fri, 06 Jul 2001 11:15:04 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please CC: me as I am not on the list (yet))

Hi,

just spent almost the whole night trying to figure out
what was wrong with the communication between my
laptop and my new Canon Powershot G1.

Setup:
 - kernel version(s) 2.4.5 and 2.4.6
 - libusb-0.1.3b
 - gphoto-2.0beta1 (and the CVS from yesterday)
 - s10sh-0.2.0 tested
 - kamera from KDE tested
 - Laptop: Dell Latitude Cpi
 - usbmodules: uhci and usbcore

Symptoms:
  - The  communication stops with an unspecified error,
    protocol error in s10sh
  - The log looks like following:

 Jul  6 03:11:18 latitude kernel: usb_control/bulk_msg: timeout
Jul  6 03:11:18 latitude kernel: usbdevfs: USBDEVFS_BULK failed dev 27 ep 0x81 
len 64 ret -110
Jul  6 03:11:23 latitude kernel: usb_control/bulk_msg: timeout
Jul  6 03:11:23 latitude kernel: usbdevfs: USBDEVFS_BULK failed dev 27 ep 0x81 
len 64 ret -110
Jul  6 03:11:28 latitude kernel: usb_control/bulk_msg: timeout
Jul  6 03:11:28 latitude kernel: usbdevfs: USBDEVFS_BULK failed dev 27 ep 0x81 
len 64 ret -110
Jul  6 03:11:33 latitude kernel: usb_control/bulk_msg: timeout
Jul  6 03:11:33 latitude kernel: usbdevfs: USBDEVFS_BULK failed dev 27 ep 0x81 
len 64 ret -110
Jul  6 03:12:22 latitude kernel: Trying to open MFT
Jul  6 03:13:27 latitude kernel: usb.c: USB disconnect on device 27

Cheking the debug from the communication indicates that it is the
camera shutting down the communication at some control message.
The strange thing is that this worked earlier today...

- Rebooting the computer into W2000 everything works

After a lot of looking around I finally got the idea of resetting the CAMERA
totally... Remove the powerpack... and (drum roll) it worked !!!

Now the questions:
- What is killing the camera?
1. The USB driver ?
2. libusb ?
3. gphoto ?
4. my USB controller?
- Why doesn't the camera reset the situation on a on/off, but needs the
  complete power removal ?

Any USB gurus out there?

BRGDS



-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


