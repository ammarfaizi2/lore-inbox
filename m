Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269593AbRHMAfq>; Sun, 12 Aug 2001 20:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269594AbRHMAfh>; Sun, 12 Aug 2001 20:35:37 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:6272 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S269593AbRHMAfX>; Sun, 12 Aug 2001 20:35:23 -0400
Message-ID: <3B771FA6.BE6566CB@randomlogic.com>
Date: Sun, 12 Aug 2001 17:30:30 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>
Subject: IDE UDMA/ATA Suckage, or something else?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had numerous problems with several different motherboards, and so
have some colleagues of mine. The motherboards are Asus A7V133 (newer
and older revisions), Tyan K7 Thunder, and Asus A7M266. They all have
NVidia AGP video cards and they vary from Duron 750MHz to Athlon
Thunderbird 1.4GHz, to Athlon MP 1.2GHz CPUs. Chipsets are VIA, AMD760,
AMD761, and AMD760MP.

In every case they all exhibit frequent lockups, often to the point that
remote connections fail requiring a reset, while running intense 3D
software, and occasional lockups when running intensive X applications.
Note that not all these systems have been using the NVidia 1.0-1251 3D
driver - at times they were just using the nv driver provided by XFree86
- and they have been run in multiple AGP configurations from 1x - 4x, FW
on and off, and in PCI only mode.

Currently, I am running a 2.4.7-ac10 SMP debug kernel on my K7 Thunder
and I was hoping things would be better, and if not then at least I
could see something in the logs if it did crash/lock. I also compiled
NVidia driver with debugging enabled. Things are no better as the system
still locks up frequently while playing Quake 3, and I can't even start
Unreal Tournament without it locking and requiring a reset (SysRq,
logging in remotely, etc. does not work). The logs tell me nothing.

What I have found is that if I disable DMA on my IBM ATA100 drive, the
system is quite stable (though it is slow as snot - running at a
ridiculous 4.5MB/sec. as compared to 35MB/sec. with UDMA33/66 enabled).
These systems also seem fine when running with Ultra160 drives and no
IDE at all (SCSI CDROM, as well as hard drives). Not only is the K7
Thunder system stable, but I can even actually play Unreal Tournament.
Other applications that previously locked the systems work fine as well.

Comments?

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
