Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313657AbSDZFSq>; Fri, 26 Apr 2002 01:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313660AbSDZFSp>; Fri, 26 Apr 2002 01:18:45 -0400
Received: from adsl-64-174-67-42.dsl.sntc01.pacbell.net ([64.174.67.42]:27535
	"EHLO moon.timocharis.com") by vger.kernel.org with ESMTP
	id <S313657AbSDZFSo>; Fri, 26 Apr 2002 01:18:44 -0400
Date: Thu, 25 Apr 2002 22:16:56 -0700
From: Akkana <akkana@shallowsky.com>
To: Andries.Brouwer@cwi.nl
Cc: DCox@SnapServer.com, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net
Subject: Re: [NEW] A SDDR-09 driver
Message-ID: <20020426051656.GF19104@shallowsky.com>
Mail-Followup-To: Akkana <akkana@shallowsky.com>, Andries.Brouwer@cwi.nl,
	DCox@SnapServer.com, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	mdharm-usb@one-eyed-alien.net
In-Reply-To: <UTC200204161548.g3GFmiD07271.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andries.Brouwer@cwi.nl writes:
> A moment ago I have made available on ftp.XX.kernel.org
> under linux/kernel/people/aeb/sddr09.c a new SDDR-09 driver,
> namely one that not only reads but also writes.
> 
> It works for me.
> 
> Will submit some version for inclusion in 2.5 next week
> or so. Feedback is welcome.

I've been using your SDDR-09 patches in both 2.4.19-pre7 and 2.5.8,
and they've been working great with my Zio.  I can finally write to
the smartmedia card as well as read from it (woohoo!) and I haven't
seen any problems that weren't already there in the existing driver
(no serious problems at all).

I'd love to see your patch get checked in to both 2.4 and 2.5.
It makes the driver a lot more useful (there aren't that many working
USB smartmedia readers for Linux), and there are a fair number
of people who have this device.  SDDR-09 is still marked experimental,
so those of us who use it know the risks. :-)

I wonder if it's worth mentioning in the configure help that this
also supports the Zio?  I'll attach a patch for that in case you want to
include it.  Curiously, the help for CONFIG_USB_STORAGE_DPCM just above
SDDR09 says it's for smartmedia as well as compact flash; but my Zio!
SM reader has product id 0003 (matching SDDR09), not 0005 (DPCM).

	...Akkana

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config.diff"

--- Documentation/Configure.help.bak	Thu Apr 25 22:13:01 2002
+++ Documentation/Configure.help	Thu Apr 25 22:13:12 2002
@@ -13895,6 +13895,7 @@
 CONFIG_USB_STORAGE_SDDR09
   Say Y here to include additional code to support the Sandisk SDDR-09
   SmartMedia reader in the USB Mass Storage driver.
+  Also works for the Microtech Zio! SmartMedia reader.
 
 USB Diamond Rio500 support
 CONFIG_USB_RIO500

--cWoXeonUoKmBZSoM--
