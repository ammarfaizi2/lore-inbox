Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269223AbRHWRjb>; Thu, 23 Aug 2001 13:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269229AbRHWRjV>; Thu, 23 Aug 2001 13:39:21 -0400
Received: from maild.telia.com ([194.22.190.101]:52473 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S269223AbRHWRjM>;
	Thu, 23 Aug 2001 13:39:12 -0400
Message-Id: <200108231739.f7NHdIm16408@maild.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Thomas Davis <tadavis@lbl.gov>, Roger Larsson <roger.larsson@norran.net>
Subject: Re: [Linux-usb-users] Report: Sony Handycam USB and Linux 2.4.9-pre2
Date: Thu, 23 Aug 2001 19:34:55 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-usb-users@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Klaus Mueller <klmuell@web.de>
In-Reply-To: <200108141108.f7EB8v612177@mailgate3.cinetic.de> <200108142242.AAA22621@mailb.telia.com> <3B84628B.F998731C@lbl.gov>
In-Reply-To: <3B84628B.F998731C@lbl.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursdayen den 23 August 2001 03:55, Thomas Davis wrote:
> Roger Larsson wrote:
> > Hi,
> >
> > [Note: I am not subscribed to linux-usb-users, please cc:]
> >
> > I have a Sony PC110E that has been working with a small patch since 2.4.0
> > But with 2.4.9-pre2 it does not work anymore...
>
> Hmm.. I just got this camera (except it's an NTSC version), and I get
>
> "not a block device" when I try to mount it.

try with fdisk (or cfdisk) it works...

>
> Again, it's recongized properly when I plug it in.
>
> This is with linux-2.4.9-pre4.  I haven't tried any other version yet.

It works up to linux-2.4.9-pre2
Something in -pre3 breaks it.

But you need this little patch to enable it.

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

*******************************************
Patch prepared by: roger.larsson@norran.net

--- linux/drivers/usb/storage/unusual_devs.h.orig	Sat Aug 18 23:29:32 2001
+++ linux/drivers/usb/storage/unusual_devs.h	Sat Aug 18 23:31:23 2001
@@ -138,6 +138,12 @@
 		US_SC_UFI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN | US_FL_START_STOP ),
 
+UNUSUAL_DEV(  0x054c, 0x002e, 0x0300, 0x0300,
+               "Sony",
+               "DSR-PC110E",
+               US_SC_SCSI, US_PR_CB, NULL,
+               US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
+
 UNUSUAL_DEV(  0x057b, 0x0000, 0x0000, 0x0299, 
 		"Y-E Data",
 		"Flashbuster-U",

