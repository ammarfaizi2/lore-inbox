Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264471AbRFIUVm>; Sat, 9 Jun 2001 16:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264485AbRFIUVd>; Sat, 9 Jun 2001 16:21:33 -0400
Received: from WARSL401PIP1.highway.telekom.at ([195.3.96.69]:14377 "HELO
	email01.aon.at") by vger.kernel.org with SMTP id <S264471AbRFIUVP>;
	Sat, 9 Jun 2001 16:21:15 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: peter konrad <kore@aon.at>
To: linux-kernel@vger.kernel.org
Subject: Problem sis 7001usb-controller & framebuffer, bug?
Date: Sat, 9 Jun 2001 22:22:19 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01060922221900.01753@pc3workstation>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hello! 

I have a notebook with this sis 7001 usb-controller and sis 630 
chipset.(shared memory 8mb), motherboard uniwill 340s2.
Kernel  2.2.x 2.4.1 -2.4.5
X-winows 3.x -4x.
Many low-cost notebooks have this chipset.
All works fine, like my usb-webcam, usb-scanner and my usb-zip-drive with
usb-ohci driver and the other required drivers, but only without framebuffer.
I need framebuffer,because there is no support from Xfree86 for my 
Tft LCD yet.
When i use the shell,zip-drive works very stable, no errors.
When i use this frambuffer-support  & X-Windows all works, but usb-devices 
are crashes after short time off running..
When i use the X-server without framebuffer, i can only use 640x480 for 
testing with bad display, but all usb devices works without any Errors and 
very stable.
I have no Io-or Int. conflicts.
It looks like a  timing problem for me, because of this problematic sis 7001, 
shared memory and framebuffer.
I tested a lot, but no succes.
All devices working stable on my Destop-machines.
I don´t know, how i resolve this strange problem with using framebuffering
and usb.

Kernel-messages from my zip-drive with framebuffering
            
kernel: bread in fat_access failed
Jun  9 20:04:42 pc3workstation kernel:  I/O error: dev 08:01, sector 120
Jun  9 20:04:42 pc3workstation kernel: bread in fat_access failed
Jun  9 20:04:42 pc3workstation kernel:  I/O error: dev 08:01, sector 120
Jun  9 20:04:42 pc3workstation kernel: bread in fat_access failed
Jun  9 20:04:42 pc3workstation kernel:  I/O error: dev 08:01, sector 23822
Jun  9 20:04:42 pc3workstation kernel:  I/O error: dev 08:01, sector 23822
Jun  9 20:05:06 pc3workstation kernel:  I/O error: dev 08:01, sector 1556

Kernel-messages from my mustek-scanner

Unable to handle kernel NULL pointer dereJun  7 13:58:21 pc3workstation 
kernel:  printing eip:
Jun  7 13:58:21 pc3workstation kernel: c01b8fed
Jun  7 13:58:21 pc3workstation kernel: *pde = 00000000
Jun  7 13:58:21 pc3workstation kernel: Oops: 0000
Jun  7 13:58:21 pc3workstation kernel: CPU:    0
Jun  7 13:58:21 pc3workstation kernel: EIP:    0010:[<c01b8fed>]
Jun  7 13:58:21 pc3workstation kernel: EFLAGS: 00010286
Jun  7 13:58:21 pc3workstation kernel: eax: 0000001c   ebx: 000009fa   ecx: 
cd68Jun  7 13:58:21 pc3workstation kernel: esi: cd687f20   edi: cd687f30   
ebp: 0000Jun  7 13:58:21 pc3workstation kernel: ds: 0018   es: 0018   ss: 0018
Jun  7 13:58:21 pc3workstation kernel: Process xsane (pid: 630, 
stackpage=cd6870Jun  7 13:58:21 pc3workstation kernel: Stack: c01b9111 
ce7993a0 000009fa cefd65cJun  7 13:58:21 pc3workstation kernel:        
cd687f20 cd88c000 00000000 cd687f2Jun  7 13:58:21 pc3workstation kernel:      
  00000000 00000000 cd686000 cd687f2Jun  7 13:58:21 pc3workstation kernel: 
Call Trace: [<c01b9111>] [<c01b9356>] [<dJun  7 13:58:21 pc3workstation 
kernel:

Thanks 
Ing.peter konrad
