Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTJ3ScM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 13:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTJ3ScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 13:32:12 -0500
Received: from mail.willden.org ([63.226.98.113]:31366 "EHLO zedd.willden.org")
	by vger.kernel.org with ESMTP id S262747AbTJ3ScG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 13:32:06 -0500
From: Shawn Willden <shawn-lkml@willden.org>
To: linux-kernel@vger.kernel.org
Subject: /dev/input/mice doesn't work in test9?
Date: Thu, 30 Oct 2003 11:32:03 -0700
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jkVo/KDr+GieAhB"
Message-Id: <200310301132.04068.shawn-lkml@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_jkVo/KDr+GieAhB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm sure I'm just missing something stupid, but google doesn't seem to turn 
up anything, so...

I'm trying to use 2.6.0-test9 on a machine with a USB mouse.  With 2.4, I 
have X configured to use /dev/input/mice (c 13 63) as my mouse pointer, 
and it works great.  With test9, XFree86 fails to start because it can't 
open the mouse.  The error is "xf86OpenSerial: Cannot open device /dev/
input/mice  No such device.".

'cat /dev/input/mice' also gives me "No such device".

/dev/input/mouse0 (c 13 32) doesn't work either.

I believe all of the relevant modules are loaded and the light on my 
optical mouse is lit, indicating that it has been powered by the usbmouse 
driver (as I understand it).

Any suggestions as to what might be wrong or how I could investigate it?

I'm attaching the output of lsmod, in case it's useful.  The test9 build 
I'm using is the one packaged by Debian.

Thanks,

Shawn.

--Boundary-00=_jkVo/KDr+GieAhB
Content-Type: text/plain;
  charset="us-ascii";
  name="lsmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lsmod"

Module                  Size  Used by
md5                     3968  1 
ipv6                  234688  8 
sd_mod                 15776  0 
sg                     34840  0 
sr_mod                 15396  0 
scsi_mod              110136  3 sd_mod,sg,sr_mod
ide_cd                 38020  0 
cdrom                  32416  2 sr_mod,ide_cd
usbmouse                5376  0 
hid                    30528  0 
smbfs                  61944  0 
uhci_hcd               30224  0 
ohci_hcd               17536  0 
ehci_hcd               22532  0 
usbcore               101980  7 usbmouse,hid,uhci_hcd,ohci_hcd,ehci_hcd
parport_pc             34220  1 
lp                     10560  0 
parport                40552  2 parport_pc,lp
via82cxxx_audio        27144  0 
uart401                11460  1 via82cxxx_audio
sound                  77996  2 via82cxxx_audio,uart401
soundcore               9152  2 via82cxxx_audio,sound
ac97_codec             17292  1 via82cxxx_audio
rtc                    12344  0 
ext3                  107688  2 
jbd                    56728  1 ext3
ide_disk               16384  4 
via82cxxx              13596  1 [unsafe]
trm290                  4996  0 
triflex                 5508  0 
slc90e66                8200  0 
sis5513                15496  0 
siimage                13028  0 
serverworks            12308  0 
sc1200                  8584  0 
rz1000                  3200  0 
piix                   11936  0 
pdc202xx_old           15388  0 
opti621                 4740  0 
ns87415                 5064  0 
hpt366                 19396  0 
hpt34x                  5504  0 
generic                 4096  0 
cy82c693                4996  0 
cs5530                  6792  0 
cs5520                  6280  0 
ide_probe_mod          16384  1 cs5520,[unsafe]
cmd64x                 11676  0 
amd74xx                12312  0 
alim15x3               11404  0 
aec62xx                 9756  0 
pdc202xx_new           11548  0 
ide_mod               137260  27 ide_cd,ide_disk,via82cxxx,trm290,triflex,slc90e66,sis5513,siimage,serverworks,sc1200,rz1000,piix,pdc202xx_old,opti621,ns87415,hpt366,hpt34x,generic,cy82c693,cs5530,cs5520,ide_probe_mod,cmd64x,amd74xx,alim15x3,aec62xx,pdc202xx_new
unix                   26928  22 
font                    8576  0 
cfbcopyarea             4096  0 
cfbimgblt               3456  0 
cfbfillrect             3968  0 

--Boundary-00=_jkVo/KDr+GieAhB--
