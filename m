Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268245AbTB1XJc>; Fri, 28 Feb 2003 18:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268246AbTB1XJc>; Fri, 28 Feb 2003 18:09:32 -0500
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:64268 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268245AbTB1XJ3>; Fri, 28 Feb 2003 18:09:29 -0500
Message-ID: <3E5FEE90.8040404@ds.pg.gda.pl>
Date: Sat, 01 Mar 2003 00:19:44 +0100
From: Pawel Golaszewski <blues@ds.pg.gda.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030227
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.63 and prior] Voodoo3 framebuffer bug
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel is compiled with gcc version 2.95.4 20010319 (prerelease)
That bug was in previous versions too.
I've got Voodoo3:
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 
01) (prog-if 00 [VGA])
         Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
         Flags: 66Mhz, fast devsel, IRQ 11
         Memory at e4000000 (32-bit, non-prefetchable) [size=32M]
         Memory at e8000000 (32-bit, prefetchable) [size=32M]
         I/O ports at c000 [size=256]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [54] AGP version 1.0
         Capabilities: [60] Power Management version 1


Framebuffer works really strange.
- when I start it in 1024x768-16@75 I have strange colours: background 
is brown-red, other colors are not good too (techno-like style). See 
dump from 1024x768 16bit: http://piorun.ds.pg.gda.pl/~blues/dump.bz2
I don't know how to make screenshot on console better, sorry...
- I can't set other refresh rates than 60Hz - from lilo I've passed 
append="video=tdfx:1024x768-16@75", but I've became 60Hz set.
- when I set resolution with fbset to i.e. 1280x1024 I have resolution 
changed but avaible area is in old size.
- when I set resolution to other than passed from lilo: when I switch 
from X, my screen is completely not usable. Manual setting resolution 
(without visibility) makes it usable again - until next switch.

P.S.: sorry for my english - I hope you understand what I mean...
-- 
pozdr. Pawe³ Go³aszewski
blues<at>ds.pg.gda.pl

