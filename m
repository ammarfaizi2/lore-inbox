Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbTC3TZf>; Sun, 30 Mar 2003 14:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbTC3TZf>; Sun, 30 Mar 2003 14:25:35 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:21337 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S261517AbTC3TZe>; Sun, 30 Mar 2003 14:25:34 -0500
Date: Sun, 30 Mar 2003 11:37:32 -0800
From: Nehal <nehal@canada.com>
Subject: mount hfs on SCSI cdrom = segfault
To: linux-kernel@vger.kernel.org
Reply-to: linux-kernel@vger.kernel.org
Message-id: <3E87477C.3050208@canada.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have a hybrid cd (both HFS, ISO9660) , i have two CD drives,
one IDE CD-Rom (actima 32x), and one SCSI CD-burner (yamaha 6416)
on an advansys cfg-510 ISA scsi card

when i try to mount on IDE using hfs with:

    mount -v -r -t hfs /dev/hdc /cdrom

it works fine, yet when i try on scsi with:

    mount -v -r -t hfs /dev/scd0 /cdrom

i get a "Segmentation fault" error, no more output given,
it also locks the drive, and sometimes i can use the
'eject' command to eject it, sometimes i cant and i gotta reboot

once though i did get a memory dump, unfortunately i didnt get
all the info, i do remember it saying this (and im sure of 2555):

    kernel bug in buffer.c:2555

im using kernel 2.4.20 with no patches

note: when i try to mount the cd using regular iso9660 fs, it
works perfectly on both cd drives,
also i have tried 2 hybrid cd's, both times i have trouble mounting
hfs on the scsi drive only

Nehal


