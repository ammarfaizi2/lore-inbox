Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263065AbTCLGiz>; Wed, 12 Mar 2003 01:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263067AbTCLGiz>; Wed, 12 Mar 2003 01:38:55 -0500
Received: from f44.law14.hotmail.com ([64.4.21.44]:37899 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263065AbTCLGiy>;
	Wed, 12 Mar 2003 01:38:54 -0500
X-Originating-IP: [24.43.17.144]
From: "M. Soltysiak" <msoltysiak@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux BUG: Memory Leak
Date: Wed, 12 Mar 2003 06:49:32 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F44Bre5NuYqYYDleNlx00025ecc@hotmail.com>
X-OriginalArrivalTime: 12 Mar 2003 06:49:33.0119 (UTC) FILETIME=[89CE24F0:01C2E863]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this here because i don't know which author screwed up.

Basically, it's a massive kernel memory leak or a VM problem.

System specs:
1 GBytes RAM
duel CPU system; 1 Ghz each.
IDE disk system, 133 Mhz bus speed, DMA.
USB mouse.
PS/2 Keyboard.
Creative Labs emu10k1-based sound card.  (LIVE!)
Asus Motherboard.

Problem:

When I boot the system, run X11 with KDE--totalling 100 M at most--things 
are fine.

When I run applications that use quite a bit of memory -- those that use 500 
Megs of RAM -- Linux keeps on allocating memory until it's full.  When full, 
system acts dead, as expected from the bad VM design.  But why does the 
system allocate memory until the RAM is full?  User applications are NOT 
leaking memory.

Example: Installing Unreal Tournament 2003 -- from the CD drive, IDE -- for 
example, playing mp3 files and browsing the web with Mozilla, and the system 
will eventually allocate memory until the system freezes.  All of RAM is 
allocated, and the system is frozen.

Possible problem: VM algorithm is not too good, and should take a lesson to 
BSD; or the kernel is leaking memory -- unknown location.  I'll look into 
the problem in a few weeks when i'm free; but now, i got work.

I'm sure many people are getting this problem...

I can fix the problem, but i got engineering projects to worry about.

Matt.




_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

