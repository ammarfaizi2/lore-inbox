Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267977AbUHUWg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267977AbUHUWg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 18:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUHUWg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 18:36:26 -0400
Received: from web41101.mail.yahoo.com ([66.218.93.17]:24922 "HELO
	web41101.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267977AbUHUWfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 18:35:52 -0400
Message-ID: <20040821223551.67748.qmail@web41101.mail.yahoo.com>
Date: Sat, 21 Aug 2004 15:35:51 -0700 (PDT)
From: Julia M <juliamrus@yahoo.com>
Subject: Fwd: LowFree memory going down -server freezes
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1521683739-1093127751=:67414"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1521683739-1093127751=:67414
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline


Note: forwarded message attached.



		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush
--0-1521683739-1093127751=:67414
Content-Type: message/rfc822

Received: from [210.11.44.114] by web41109.mail.yahoo.com via HTTP; Wed, 18 Aug 2004 16:44:56 PDT
Date: Wed, 18 Aug 2004 16:44:56 -0700 (PDT)
From: Julia M <juliamrus@yahoo.com>
Subject: LowFree memory going down -server freezes
To: linux-poweredge@dell.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Length: 1220

Dear Team,



I am using Linux version 2.4.9-e.3smp
(bhcompile@stripples.devel.redhat.com) (gcc version 2
.96 20000731 (Red Hat Linux 7.2 2.96-108.1)) #1 SMP
Fri May 3 16:48:54 EDT 2002
on a DELL PowerEdge 6650 server and it got 4GB RAM. It
freezes after running for about 2 days when it's
LowMem parameter hits
32000KB mark.When that happens only a power off could
save it, and won't allow even to write a shutdown
command at prompt.
Please take a look at the meminfo output taken within
10 minutes apart from each other during normal use of
the server.Server gets around 250 connections to its
Informix database during normal use.


root@dwh#cat /proc/meminfo
        total:    used:    free:  shared: buffers: 
cached:
Mem:  3692048384 1536348160 2155700224 674283520
146186240 170840064
Swap: 2154938368        0 2154938368
MemTotal:      3605516 kB
MemFree:       2105176 kB
MemShared:      658480 kB
Buffers:        142760 kB
Cached:         166836 kB
SwapCached:          0 kB
Active:          89960 kB
Inact_dirty:    878116 kB
Inact_clean:         0 kB
Inact_target:   917488 kB
HighTotal:     2752448 kB
HighFree:      1476612 kB
LowTotal:       853068 kB
LowFree:        628564 kB
SwapTotal:     2104432 kB
SwapFree:      2104432 kB
BigPagesFree:        0 kB


---

After 10 minutes 

cat /proc/meminfo
        total:    used:    free:  shared: buffers: 
cached:
Mem:  3692048384 1541705728 2150342656 674291712
146767872 173260800
Swap: 2154938368        0 2154938368
MemTotal:      3605516 kB
MemFree:       2099944 kB
MemShared:      658488 kB
Buffers:        143328 kB
Cached:         169200 kB
SwapCached:          0 kB
Active:          89820 kB
Inact_dirty:    881196 kB
Inact_clean:         0 kB
Inact_target:   917488 kB
HighTotal:     2752448 kB
HighFree:      1472012 kB
LowTotal:       853068 kB
LowFree:        627932 kB
SwapTotal:     2104432 kB
SwapFree:      2104432 kB
BigPagesFree:        0 kB


See the LowFree has dropped to 627932 kb from 628564
kB.
I don't understand the reason behind this. We have
test server
with the same Linux configuration running on an old
IBM machine.
No dropping in LowFree Memory. Is there any parameter
I should tune to
overcome this??If this a known issue with Linux-Dell
combination,
what is the solution??
Also I was looking through my log 
files and I am seeing a line in my message log file
that says bad pte ...
An answer to this much appreciated.



Cheers,
JM



		
__________________________________
Do you Yahoo!?
Y! Messenger - Communicate in real time. Download now. 
http://messenger.yahoo.com

--0-1521683739-1093127751=:67414--
