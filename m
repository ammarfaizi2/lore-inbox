Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284882AbRLURgB>; Fri, 21 Dec 2001 12:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284879AbRLURfm>; Fri, 21 Dec 2001 12:35:42 -0500
Received: from isis.telemach.net ([213.143.65.10]:23313 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S284874AbRLURfh>;
	Fri, 21 Dec 2001 12:35:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problems with ATA hard disk(s)
Date: Fri, 21 Dec 2001 18:39:27 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011221173533.C66C87A102@isis.telemach.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

I am a beginner when it comes to Linux, so please bear with me.

I have two ATA hard disks. Proc/../model says Maxtor 91021U2 and ST31722A 
respectively.  The /dev/hda one is  Maxtor 91021U2.  The mainboard model is 
P5I430TX TITANIUM IB and CPU is Intel P200 MMX. Softwarewise I am using 
ReiserFS and 2.4.16 version of the kernel. 
I tried to tune HDD performance, so I put this into /etc/rc.local:
/sbin/hdparm -c1 -A1 -m16 -d1 /dev/hda

When I look at the HDD settings after boot, I see that almost everything is 
turned off:
[root@tm-68-65 grega]# /sbin/hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1245/255/63, sectors = 20010816, start = 0

In the logs I have bunch of such errors:

messages:Dec 21 16:21:27 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 16:21:27 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 16:21:27 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 16:21:27 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 16:22:41 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 16:22:41 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 16:22:41 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 16:22:42 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 17:48:56 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 17:48:56 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 17:48:56 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }
messages:Dec 21 17:48:56 tm-68-65 kernel: hda: dma_intr: error=0x84 { 
DriveStatusError BadCRC }

If you need more info, don't hesitate to ask. Please CC me, as I am not on 
the list.

Regards,
Grega Fajdiga
