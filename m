Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267009AbRHFGlc>; Mon, 6 Aug 2001 02:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbRHFGlW>; Mon, 6 Aug 2001 02:41:22 -0400
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:12510 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S267009AbRHFGlO>; Mon, 6 Aug 2001 02:41:14 -0400
Subject: /proc/<n>/maps growing...
From: David Luyer <david_luyer@pacific.net.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 06 Aug 2001 16:41:21 +1000
Message-Id: <997080081.3938.28.camel@typhaon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is from evolution-mail.

It _looks_ like lots of contiguous, equal protection mappings which
should be
merged:


40f00000-40f08000 rw-p 000bf000 00:00 0
40f08000-40f0e000 rw-p 000c7000 00:00 0
[... 37 lines deleted ...]
40f5e000-40f60000 rw-p 0011d000 00:00 0
40f60000-40f63000 rw-p 0011f000 00:00 0
40f63000-40f64000 rw-p 00000000 00:00 0
40f64000-40f65000 rw-p 00001000 00:00 0
[... 26 lines deleted ...]
40f88000-40f89000 rw-p 00025000 00:00 0
40f89000-40f8a000 rw-p 00026000 00:00 0
40f8a000-40f8b000 rw-p 00149000 00:00 0
40f8b000-40f8c000 rw-p 0014a000 00:00 0
[... 99 lines deleted ...]
40ff7000-40ff8000 rw-p 001b6000 00:00 0
40ff8000-40ff9000 rw-p 001b7000 00:00 0
40ff9000-40ffa000 rw-p 001b8000 00:00 0
40ffa000-41000000 ---p 001b9000 00:00 0
41000000-41026000 r--s 00000000 00:03 110985227  /SYSV00000000 (deleted)
41026000-41044000 r--s 00000000 00:03 111018010  /SYSV00000000 (deleted)
41100000-41101000 rw-p 000bc000 00:00 0
41101000-41102000 rw-p 00000000 00:00 0
41102000-41103000 rw-p 00001000 00:00 0
41103000-41104000 rw-p 00002000 00:00 0
41104000-41105000 rw-p 00003000 00:00 0
41105000-41108000 ---p 00004000 00:00 0
41108000-41200000 ---p 000c4000 00:00 0

and then a bit later:

[... much deleted ...]
40ff7000-40ff8000 rw-p 001b6000 00:00 0
40ff8000-40ff9000 rw-p 001b7000 00:00 0
40ff9000-40ffa000 rw-p 00000000 00:00 0
40ffa000-40ffc000 rw-p 00001000 00:00 0
40ffc000-40ffd000 rw-p 00000000 00:00 0
40ffd000-40ffe000 rw-p 001bc000 00:00 0
40ffe000-40fff000 rw-p 001bd000 00:00 0
40fff000-41000000 rw-p 001be000 00:00 0
41000000-41026000 r--s 00000000 00:03 110985227  /SYSV00000000 (deleted)
41026000-41044000 r--s 00000000 00:03 111018010  /SYSV00000000 (deleted)
41100000-41101000 rw-p 000bc000 00:00 0
41101000-41102000 rw-p 00000000 00:00 0
41102000-41103000 rw-p 00001000 00:00 0
41103000-41104000 rw-p 00002000 00:00 0
41104000-41105000 rw-p 00003000 00:00 0
41105000-41106000 rw-p 00004000 00:00 0
41106000-41107000 rw-p 00005000 00:00 0
41107000-41108000 rw-p 00006000 00:00 0
41108000-41109000 rw-p 000c4000 00:00 0
41109000-4110a000 rw-p 000c5000 00:00 0
4110a000-4110c000 rw-p 000c6000 00:00 0
4110c000-4110d000 rw-p 000c8000 00:00 0
4110d000-4110e000 rw-p 000c9000 00:00 0
4110e000-4110f000 rw-p 000ca000 00:00 0
4110f000-41110000 rw-p 000cb000 00:00 0
41110000-41112000 rw-p 000cc000 00:00 0
41112000-41113000 rw-p 000ce000 00:00 0
41113000-41115000 rw-p 000cf000 00:00 0
41115000-41200000 ---p 000d1000 00:00 0

So the maps are slowly splitting up even though the permissions are the
same.

It seems to keep growing over time but Evolution isn't 100% stable yet
so it
crashes for no apparent reason every 6 hours or so.. unless that could
be when
it hits some 'limit' on the number of mappings allowed? 
-- 
David Luyer                                     Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C    Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                      NASDAQ:  PCNTF
