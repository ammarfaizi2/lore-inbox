Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSKUBjr>; Wed, 20 Nov 2002 20:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSKUBjr>; Wed, 20 Nov 2002 20:39:47 -0500
Received: from speedy.suonline.net ([217.26.75.13]:2779 "EHLO
	speedy.suonline.net") by vger.kernel.org with ESMTP
	id <S262803AbSKUBjp>; Wed, 20 Nov 2002 20:39:45 -0500
From: Rizsanyi Zsolt <rizsanyi@myrealbox.com>
Reply-To: rizsanyi@neobee.net
Subject: Fwd: Re: agp driver update for linux
Date: Thu, 21 Nov 2002 02:20:15 +0100
User-Agent: KMail/1.5
To: linux-kernel@vger.kernel.org
Cc: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211210220.15856.rizsanyi@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have the problem that when trying to use my TV Card my machine totally 
freezes after a few seconds.
After some investigation and reporting on video4linux-list@redhat.com it 
became apparent, that the problem is with my AliMagik1 chipset. And all the 
AliMagik1 users are affected with this problem.

After some searching on the relevant sites I have found this FAQ:
---------------------------------
Question :

 When using PCI TV card with A7A266, the system will hang when TV program is
activated.

Answer :

 This is a compatibility issue between Ali Chipset and PCI Card. Please
upgrade to ALi AGP Miniport Driver v1.74 and later or change the BIOS setting
from BIOS -> Advanced -> PCI Configuration -> PCI Latency Timer, set as 10
(Default is 32) to increase further compatibility
---------------------------------

Since the bios setting was not enough, I have contacted Ali support to ask 
about what was that the Windows driver fixed. See the attached mail below.

It would be pretty good if somebody could implement the things described 
below, and send me the patch, so I could test it out.

Does somebody volunteer for that?
It would be nice if the patch would be against a 2.4.x kernel. (like 2.4.19 or 
2.4.20 prerelease).

Thanks
Zsolt

----------  Forwarded Message  ----------

Subject: Re: agp driver update for linux
Date: Wednesday 20 November 2002 12:17
From: ALi_Support_Team@ali.com.tw
To: 

Dear Sir,

I'm sorry we can't provide an AGP driver for Linux to fix this problem as in
 Windows. But we are willing to provide the information to fix this problem.
 If you can help us pass this information to Linux developer, please help us
 find which version of driver or kernel will contains the fix. Hence we can
 post this information in our website FAQ to let more users know where to get
 the solution. My mail address is wktsai@ali.com.tw.

Below is the workaround we add in our driver:
1. scan all devices located at bus 0
2. if device class code (PCI config offset 0xb~0xa) is 0x400, do
    2a. set latency timer (offset 0xd) of matched device to 0xa
    2b. set offset 0x40 bit 1 of matched device to 1


Best Regards
ALi Support Team

-------------------------------------------------------

