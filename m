Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271326AbRIDPDB>; Tue, 4 Sep 2001 11:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269796AbRIDPCw>; Tue, 4 Sep 2001 11:02:52 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:15372 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269756AbRIDPCo>; Tue, 4 Sep 2001 11:02:44 -0400
Message-ID: <3B94ECB2.6634FE9E@t-online.de>
Date: Tue, 04 Sep 2001 17:01:06 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Allaire <pallaire@gameloft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Failure to mount root fs ...
In-Reply-To: <9A1957CB9FC45A4FA6F35961093ABB84043F1D0E@srvmail-mtl.ubisoft.qc.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Allaire schrieb:
> 
> Hi all,
> 
> I am currently trying to boot for a DiscOnChip with mtd drivers. When I boot
> the system stop with the following message : "Kernel panic: VFS: Unable to
> mount root fs on 03:05" !
> 
> I know that o3:05 mean : /dev/hda5. HTis is where I did compile my kernel
> ... but now the kernel is on /dev/nftla1 ... but the lilo.conf on this
> device is configured to nftla1 and I did run lilo??? so I dont know where
> the kernel take this information about boot ing on /dev/hda5 ??? I 

The Kernel gets this info at compile-time, it is only overridable by a
kernel-argument ("root=..."), this is what lilo does.

If you want to change this so called "root-device" inside the kernel,
you should take a look at the tool "rdev" and its man-page.

I had the same problem some time ago as i wanted to build a
boot-diskette without any loader like lilo or loadlin, etc.

As the kernel contains an i386 bootsector, it should be able to boot
itself if it is copied on a diskette and the bios jumps to its
begin...but then you cannot say the kernel, where the root-filesystem
is, so you have to change the root-device inside the compiled kernel,
and this does "rdev". 

Unfortunately, it did not work for me, so i switched back to
loadlin...:-((...but i tried it only one time, perhaps *i* made a
mistake and not the tool...:-)

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
