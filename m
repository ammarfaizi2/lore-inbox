Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317760AbSFSELL>; Wed, 19 Jun 2002 00:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317761AbSFSELK>; Wed, 19 Jun 2002 00:11:10 -0400
Received: from pcp01314487pcs.hatisb01.ms.comcast.net ([68.63.220.2]:59529
	"EHLO bacchus.jdhouse.org") by vger.kernel.org with ESMTP
	id <S317760AbSFSELI>; Wed, 19 Jun 2002 00:11:08 -0400
Date: Tue, 18 Jun 2002 23:13:55 -0500 (CDT)
From: "Jonathan A. Davis" <davis@jdhouse.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VIA KT266 PCI-related crashes fixed.  Now whats the catch?
Message-ID: <Pine.LNX.4.44.0206182240330.29752-100000@bacchus.jdhouse.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


G'day Alan, all,

In November, I assembled a new machine using a Soyo Dragon+ mb with a
Pinnacle PCTV/Pro card as the only add-in board (I have an ATI 7500 in the
AGP slot).  Very quickly I learned that any heavy disk activity (from two
UDMA100 drives) during TV card use would lock the system tight.  As long
as I didn't use the TV card, the system was completely solid -- under
heavy disk, sound, net usage, etc.  I tried moving the card around,
playing with BIOS, upgrading BIOS, with no success.  I dug around in
quirks.c and put a serious dent in google's usage reports trying to find
answers.  About the time I was concluding that I had a defective mb, a
friend decided to install Linux on his KT266 system also.  After the
install, we popped a PCTV (non-PRO minus FM radio) into it and ended up
duplicating my machines's crashing behaviour.

About a month ago, after giving up and either avoiding TV card use (which
given the state of US TV isn't a completely bad thing :-), or resigning
myself to not doing serious work if I had the TV card on, I stumbled
across Serguei Miridonov's site (http://www.cicese.mx/~mirsev/Linux/VIA/).  
His small module changes PCI config register 0x75 from 0x01 to 0x07 and
clears all the bits on 0x76 (originally set to 0x10 on my mb).  The result
has been perfect stability for both boards with TV cards and as much disk
and other I/O as bonnie and friends could generate.

Alan, given that you are one of gurus on VIA chipset quirks, what am I 
trading off on this?  Is this an isolated quirk, or have I stumbled across 
something mildly useful to others?

Any insights would be appreciated.

Many thanks,

-- 

-Jonathan <davis@jdhouse.org>


