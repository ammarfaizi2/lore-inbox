Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314056AbSDZOiY>; Fri, 26 Apr 2002 10:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314057AbSDZOiY>; Fri, 26 Apr 2002 10:38:24 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:40162 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314056AbSDZOiX> convert rfc822-to-8bit; Fri, 26 Apr 2002 10:38:23 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
Reply-To: mcp@linux-systeme.de
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.18 and strange OOM Killer behaveness
Date: Fri, 26 Apr 2002 16:38:08 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204261636.14573.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

i just opened an 800mb movie file with pico/nano, waited for the OOM, and here 
it is, have a look:

Apr 26 16:10:45 codeman kernel: Out of Memory: Killed process 19789 (apache).
Apr 26 16:10:46 codeman kernel: Out of Memory: Killed process 27828 (apache).
Apr 26 16:10:48 codeman kernel: Out of Memory: Killed process 14554 (apache).
Apr 26 16:10:50 codeman kernel: Out of Memory: Killed process 19893 (apache).
Apr 26 16:10:52 codeman kernel: Out of Memory: Killed process 32036 (apache).
Apr 26 16:10:54 codeman kernel: Out of Memory: Killed process 8370 (apache).
Apr 26 16:10:56 codeman kernel: Out of Memory: Killed process 680 (mysqld).
Apr 26 16:10:56 codeman kernel: Out of Memory: Killed process 7638 (mysqld).
Apr 26 16:10:56 codeman kernel: Out of Memory: Killed process 26780 (mysqld).
Apr 26 16:10:56 codeman kernel: Out of Memory: Killed process 26038 (mysqld).
Apr 26 16:11:01 codeman kernel: Out of Memory: Killed process 3914 (pico).
Apr 26 16:11:01 codeman kernel: VM: killing process pico
Apr 26 16:11:04 codeman kernel: Out of Memory: Killed process 20471 (squid).

So, you guess, apache, mysqld, squid and the causer pico are killed, but NO, 
ONLY, and i mean ONLY pico was killed, all the other Processes listed above 
are running fine, accepting connections, short: works fine!!
And yes, its reproduceable !!

The above is a kernel without rmap!

I also tried this with rmap enabled kernel, no OOM Messages appears, but the 
system freezes. It does NOT accept any input on keyboard, mouse or via the 
network (e.g ping, traceroute, telnet to smtp port etc.). Also, if the system 
does not accept any input, the harddisk is doing something, i've waited ~ 45 
minutes, system was still not accepting anything, harddisk was doing 
anything. This was rmap12h with 2.4.18.

Kinda strange, isn't it?! :-)

I like it, cause only the causer get killed, but why those syslog messages?!
Syslogd lies like a trooper ;)

-- 
Kind regards
	Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824  080A 569D E2E3 DB44 1A16
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.
