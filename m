Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVKOLmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVKOLmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 06:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVKOLmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 06:42:39 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:59068 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751427AbVKOLmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 06:42:38 -0500
From: Duncan Sands <baldrick@free.fr>
To: mchehab@brturbo.com.br
Subject: 2.6.15-rc1-git1: BTTV: no picture with grabdisplay; later, an Oops
Date: Tue, 15 Nov 2005 12:41:59 +0100
User-Agent: KMail/1.8.3
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ImceDoSj0Hm/Ppa"
Message-Id: <200511151242.00047.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ImceDoSj0Hm/Ppa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Linux version 2.6.15-rc1-git1 (root@baldrick) (gcc version 4.0.2 20050808 (=
prerelease) (Ubuntu 4.0.1-4ubuntu9)) #1 Mon Nov 14 19:10:23 CET 2005
x86

When I change channels, a picture flashes onto the screen for a fraction of
a second, then the screen becomes black.  The picture glimpsed seems to be =
four
copies of the tv show, arranged in a 2x2 matrix.

This was not the case with 2.6.14.  Between 2.6.14 and the current kernel, I
changed my .config by turning on all kernel debugging options except for
CONFIG_DEBUG_KOBJECT and CONFIG_RCU_TORTURE_TEST (there is a note in .config
saying "Page alloc debug is incompatible with Software Suspend on i386").

xawtv produced the following in my .xsession-errors:

This is xawtv-3.94, running on Linux/i686 (2.6.15-rc1-git1)
Warning: Cannot convert string "-*-ledfixed-medium-r-*--39-*-*-*-c-*-*-*" t=
o type FontStruct

sizeof(RADEONDRIRec) =3D=3D 100, devPrivSize 100
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
v4l2: read: Input/output error
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
v4l2: read: Input/output error
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
v4l2: read: Input/output error
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument
v4l2: read: Input/output error
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_QBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x0=
 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;t=
imecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userbi=
ts=3D"";sequence=3D0;memory=3DMMAP): Bad address
ioctl: VIDIOC_DQBUF(index=3D0;type=3DVIDEO_CAPTURE;bytesused=3D0;flags=3D0x=
0 [];field=3DANY;;timecode.type=3D0;timecode.flags=3D0;timecode.frames=3D0;=
timecode.seconds=3D0;timecode.minutes=3D0;timecode.hours=3D0;timecode.userb=
its=3D"";sequence=3D0;memory=3Dunknown): Invalid argument

The card is a cheap and nasty wintv:

0000:00:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video=
 Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Flags: bus master, medium devsel, latency 32, IRQ 20
        Memory at dfbfe000 (32-bit, prefetchable) [size=3D4K]
        Capabilities: <available only to root>

on a VIA chipset:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A=
/333]
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Flags: bus master, 66MHz, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
        Capabilities: <available only to root>

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/=
333 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: dfc00000-dfcfffff
        Prefetchable memory behind bridge: bfb00000-dfafffff
        Capabilities: <available only to root>

I don't use overlay, since it always eventually manages to freeze the machi=
ne.

What's more, after quitting xawtv and the window manager session, I got the=
 following Oops:

[17179726.148000] bttv0: OCERR @ 1ba9b01c,bits: HSYNC OFLOW FBUS OCERR*
[17179726.228000] bttv0: OCERR @ 1ba9b01c,bits: HSYNC OFLOW FBUS OCERR*
[17179726.308000] bttv0: OCERR @ 1ba9b01c,bits: HSYNC OFLOW FBUS OCERR*
[17179726.388000] bttv0: OCERR @ 1ba9b01c,bits: HSYNC OFLOW FBUS OCERR*
[17179726.468000] bttv0: OCERR @ 1ba9b01c,bits: HSYNC OFLOW FBUS OCERR*
[17179726.548000] bttv0: OCERR @ 1ba9b01c,bits: HSYNC OFLOW FBUS OCERR*
[17179726.588000] bttv0: timeout: drop=3D0 irq=3D1329/1329, risc=3D1ba9b01c=
, bits: OFLOW
[17179726.612000] bttv0: reset, reinitialize
[17179726.624000] bttv0: PLL: 28636363 =3D> 35468950 . ok
[17179733.028000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.068000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.108000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.148000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.188000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.228000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.268000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.308000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.348000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.388000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.428000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179733.468000] bttv0: timeout: drop=3D0 irq=3D1357/1357, risc=3D1895fe5c=
, <6>bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW FBUS OCERR*
[17179733.504000] bits: VSYNC HSYNC OFLOW FBUS
[17179733.520000] bttv0: reset, reinitialize
[17179733.532000] bttv0: PLL: 28636363 =3D> 35468950 . ok
[17179753.292000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.332000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.372000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.412000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.452000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.492000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.532000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.572000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.612000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.652000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.692000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179753.732000] bttv0: timeout: drop=3D0 irq=3D1398/1398, risc=3D18e7f0c0=
, <6>bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW FBUS OCERR*
[17179753.768000] bits: VSYNC HSYNC OFLOW
[17179753.780000] bttv0: reset, reinitialize
[17179753.796000] bttv0: PLL: 28636363 =3D> 35468950 . ok
[17179767.788000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179767.828000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179767.868000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179767.908000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179767.948000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179767.988000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179768.028000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179768.068000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179768.108000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179768.148000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179768.188000] bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW OCERR*
[17179768.228000] bttv0: timeout: drop=3D0 irq=3D1443/1443, risc=3D18b2ff8c=
, <6>bttv0: OCERR @ 1ba9b01c,bits: VSYNC HSYNC OFLOW FBUS OCERR*
[17179768.264000] bits: VSYNC HSYNC OFLOW FBUS
[17179768.280000] bttv0: reset, reinitialize
[17179768.292000] bttv0: PLL: 28636363 =3D> 35468950 . ok
[17179772.660000] Unable to handle kernel paging request at virtual address=
 15ece000
[17179772.660000]  printing eip:
[17179772.660000] 15ece000
[17179772.660000] *pde =3D 00000000
[17179772.660000] Oops: 0000 [#1]
[17179772.660000] Modules linked in: af_packet rfcomm l2cap bluetooth ipv6 =
cpufreq_stats cpufreq_powersave cpufreq_ondemand cpufreq_userspace freq_tab=
le cpufreq_conservative usblp radeon drm tun video battery container button=
 ac ipt_TOS ipt_MASQUERADE ipt_REJECT ipt_LOG ipt_state ipt_pkttype ipt_own=
er ipt_iprange ipt_physdev ipt_multiport ipt_conntrack iptable_mangle ip_na=
t_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_nat ip_conntrack_irc ip_conntra=
ck_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables floppy pcspk=
r rtc snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd=
_via82xx snd_mpu401_uart i2c_viapro via_ircc irda crc_ccitt snd_bt87x bt878=
 tuner tvaudio bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_=
risc tveeprom i2c_core videodev snd_cs46xx gameport snd_rawmidi snd_seq_dev=
ice snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer=
 snd soundcore snd_page_alloc shpchp pci_hotplug via_agp agpgart nls_cp437 =
ntfs reiserfs dm_mod tsdev parport_pc lp parport mousedev psmouse md_mod ex=
t3 jbd mbcache thermal processor fan ehci_hcd uhci_hcd usbcore 8139too 8139=
cp mii ide_cd cdrom ide_disk ide_generic via82cxxx generic ide_core unix vg=
a16fb vgastate cfbimgblt cfbfillrect cfbcopyarea tileblit font
[17179772.660000] CPU:    0
[17179772.660000] EIP:    0060:[<15ece000>]    Not tainted VLI
[17179772.660000] EFLAGS: 00210002   (2.6.15-rc1-git1)=20
[17179772.660000] EIP is at 0x15ece000
[17179772.660000] eax: d8b1c00c   ebx: 18000bf8   ecx: 00000001   edx: 0000=
0001
[17179772.660000] esi: 18bffc08   edi: 00000001   ebp: dfbf0cf8   esp: dfbf=
0cd4
[17179772.660000] ds: 007b   es: 007b   ss: 0068
[17179772.660000] Process gdm (pid: 10407, threadinfo=3Ddfbf0000 task=3Ddcb=
d8000)
[17179772.660000] Stack: c01186b3 d8b1c00c 00000001 00000000 00000000 c15a2=
848 c15a2838 00000001=20
[17179772.660000]        00200286 dfbf0d24 c011871f c15a2838 00000001 00000=
001 00000000 00000000=20
[17179772.660000]        00000001 c15a2838 de4b2820 de4b291c dfbf0d44 c0252=
1b6 00000000 dfbf0d44=20
[17179772.660000] Call Trace:
[17179772.660000]  [<c0103f4c>] show_stack+0x9c/0xe0
[17179772.660000]  [<c010410f>] show_registers+0x15f/0x1f0
[17179772.660000]  [<c0104316>] die+0xd6/0x160
[17179772.660000]  [<c02c6dd9>] do_page_fault+0x209/0x6b8
[17179772.660000]  [<c0103bd3>] error_code+0x4f/0x54
[17179772.660000]  [<c011871f>] __wake_up+0x3f/0x60
[17179772.660000]  [<c02521b6>] sock_def_readable+0x46/0x90
[17179772.660000]  [<e08b5f8f>] unix_dgram_sendmsg+0x4ef/0x580 [unix]
[17179772.660000]  [<c024e56b>] sock_sendmsg+0xfb/0x120
[17179772.660000]  [<c024fb8b>] sys_sendto+0xbb/0xe0
[17179772.660000]  [<c024fbe6>] sys_send+0x36/0x40
[17179772.660000]  [<c02504d2>] sys_socketcall+0x142/0x260
[17179772.660000]  [<c01030bf>] sysenter_past_esp+0x54/0x75
[17179772.660000] Code:  Bad EIP value.
[17179772.660000]  BUG: spinlock cpu recursion on CPU#0, klogd/9954
[17179773.552000]  lock: c15a2838, .magic: dead4ead, .owner: gdm/10407, .ow=
ner_cpu: 0
[17179773.552000]  [<c0103fae>] dump_stack+0x1e/0x20
[17179773.552000]  [<c01e1699>] spin_bug+0xa9/0xb0
[17179773.552000]  [<c01e1809>] _raw_spin_lock+0x79/0x90
[17179773.552000]  [<c02c64f2>] _spin_lock_irqsave+0x12/0x20
[17179773.552000]  [<c01186fb>] __wake_up+0x1b/0x60
[17179773.552000]  [<c02521b6>] sock_def_readable+0x46/0x90
[17179773.552000]  [<e08b5f8f>] unix_dgram_sendmsg+0x4ef/0x580 [unix]
[17179773.552000]  [<c024e9b1>] sock_aio_write+0xf1/0x140
[17179773.552000]  [<c0161c5a>] do_sync_write+0xba/0x110
[17179773.552000]  [<c0161e4d>] vfs_write+0x19d/0x1b0
[17179773.552000]  [<c0161f17>] sys_write+0x47/0x70
[17179773.552000]  [<c01030bf>] sysenter_past_esp+0x54/0x75
[17179773.552000] BUG: spinlock lockup on CPU#0, klogd/9954, c15a2838
[17179773.552000]  [<c0103fae>] dump_stack+0x1e/0x20
[17179773.552000]  [<c01e1756>] __spin_lock_debug+0xb6/0xf0
[17179773.552000]  [<c01e17f7>] _raw_spin_lock+0x67/0x90
[17179773.552000]  [<c02c64f2>] _spin_lock_irqsave+0x12/0x20
[17179773.552000]  [<c01186fb>] __wake_up+0x1b/0x60
[17179773.552000]  [<c02521b6>] sock_def_readable+0x46/0x90
[17179773.552000]  [<e08b5f8f>] unix_dgram_sendmsg+0x4ef/0x580 [unix]
[17179773.552000]  [<c024e9b1>] sock_aio_write+0xf1/0x140
[17179773.552000]  [<c0161c5a>] do_sync_write+0xba/0x110
[17179773.552000]  [<c0161e4d>] vfs_write+0x19d/0x1b0
[17179773.552000]  [<c0161f17>] sys_write+0x47/0x70
[17179773.552000]  [<c01030bf>] sysenter_past_esp+0x54/0x75

In the past I've seen different Oops, in different places.  This smells lik=
e memory
corruption to me.

Best wishes,

Duncan.

--Boundary-00=_ImceDoSj0Hm/Ppa
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
4fRURrjRAOH/AfuPEzqAAAEA

--Boundary-00=_ImceDoSj0Hm/Ppa--
