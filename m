Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSFHQwo>; Sat, 8 Jun 2002 12:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317423AbSFHQwn>; Sat, 8 Jun 2002 12:52:43 -0400
Received: from 54.61.26.24.cfl.rr.com ([24.26.61.54]:52999 "HELO
	potatoho.dyndns.org") by vger.kernel.org with SMTP
	id <S317422AbSFHQwn>; Sat, 8 Jun 2002 12:52:43 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Chris Faherty <rallymonkey@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
Subject: Logitech Mouseman Dual Optical defaults to 400cpi
Date: Sat, 8 Jun 2002 12:53:17 -0400
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020608165243Z317422-22020+923@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure which list to write about this.  I've written Logitech but they 
gave me back a non-answer.. something about clicking some options with their 
Windows software.

The Dual Optical mouse has a sensor(s), Agilent ADNS-2051, which is capable 
of 400cpi (default) and 800cpi.  Logitech decided to leave this setting up 
to the driver software, and so the mouse defaults to 400cpi and 100rps 
(report rate, which is 200rps max) if you use a generic HID driver.  Even on 
Windows if you don't install MouseWare, you will only see 400cpi.

I can't find any information on how to switch it into 800cpi mode.  I have 
hooked it up to a Windows machine with their MouseWare driver and used 
usbsniff to log what happens during a hotplug.  But I don't know what I am 
looking at, I don't understand USB communications.

Can someone suggest a remedy?  Here is a portion of the USB sniff log which 
writes to the mouse during hotplug:

00000157	0.32087600	>>>>>>> URB 6 going down...	
00000158	0.32089680	-- URB_FUNCTION_CLASS_INTERFACE:	
00000159	0.32093600	  TransferFlags          = 00000000 
(USBD_TRANSFER_DIRECTION_OUT, ~USBD_SHORT_TRANSFER_OK)	
00000160	0.32095520	  TransferBufferLength = 00000000	
00000161	0.32097360	  TransferBuffer       = 00000000	
00000162	0.32099200	  TransferBufferMDL    = 00000000	
00000163	0.32100800	 	
00000164	0.32101200	    no data supplied	
00000165	0.32103200	  UrbLink                 = 00000000	
00000166	0.32105120	  RequestTypeReservedBits = 22	
00000167	0.32106960	  Request                 = 0a	
00000168	0.32108880	  Value                   = 0000	
00000169	0.32110720	  Index                   = 0000	

and

00000208	0.32805280	>>>>>>> URB 8 going down...	
00000209	0.32807200	-- URB_FUNCTION_VENDOR_DEVICE:	
00000210	0.32810800	  TransferFlags          = 00000000 
(USBD_TRANSFER_DIRECTION_OUT, ~USBD_SHORT_TRANSFER_OK)	
00000211	0.32812640	  TransferBufferLength = 00000000	
00000212	0.32814480	  TransferBuffer       = 00000000	
00000213	0.32816320	  TransferBufferMDL    = 00000000	
00000214	0.32817760	 	
00000215	0.32818320	    no data supplied	
00000216	0.32820240	  UrbLink                 = 00000000	
00000217	0.32822080	  RequestTypeReservedBits = 00	
00000218	0.32824000	  Request                 = 02	
00000219	0.32825840	  Value                   = 000e	
00000220	0.32827760	  Index                   = 0004	

-- 
/* Chris Faherty <rallymonkey@bellsouth.net> */
