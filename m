Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283270AbRK2PZ4>; Thu, 29 Nov 2001 10:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283276AbRK2PZq>; Thu, 29 Nov 2001 10:25:46 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:38930 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S283270AbRK2PZi>;
	Thu, 29 Nov 2001 10:25:38 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15366.21354.879039.718967@abasin.nj.nec.com>
Date: Thu, 29 Nov 2001 10:25:30 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 freezed up with eepro100 module
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 2.4.16 kernel finally makes my clients happy with memory
management.  The systems that froz up is a Dell of some sort or other
with two 1Ghz Pentium IIIs and 4G of memory.  But, now I seems to be
having ethernet problems.  With and eepro100 card:

  Bus  0, device   4, function  0:
    Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 8).
      IRQ 16.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfeb02000 [0xfeb02fff].
      I/O at 0xfcc0 [0xfcff].
      Non-prefetchable 32 bit memory at 0xfe900000 [0xfe9fffff].

loaded as a module, being used heavily, the system froze with nothing
on the console when I saw it.  Normal log messages until:

Nov 28 22:03:31 ps1 kernel: eth0: can't fill rx buffer (force 0)!
Nov 28 22:05:03 ps1 kernel: 0001.
Nov 28 22:05:03 ps1 kernel: eth0: can't fill rx buffer (force 1)!
Nov 28 22:05:04 ps1 kernel: eth0: can't fill rx buffer (force 0)!
Nov 28 22:05:05 ps1 kernel: eth0: can't fill rx buffer (force 0)!
Nov 28 22:05:06 ps1 kernel: eth0: can't fill rx buffer (force 1)!
Nov 28 22:05:06 ps1 kernel: eth0: can't fill rx buffer (force 0)!
Nov 28 22:05:07 ps1 kernel: eth0: can't fill rx buffer (force 1)!
Nov 28 22:05:08 ps1 kernel: eth0: can't fill rx buffer (force 1)!
Nov 28 22:05:09 ps1 kernel: eth0: can't fill rx buffer (force 0)!
Nov 28 22:05:17 ps1 last message repeated 10 times
Nov 28 22:05:18 ps1 kernel: KERNEL: assertion (flags&MSG_PEEK) failed at tcp.c(1463):tcp_recvmsg
Nov 28 22:07:48 ps1 kernel: eth0: card reports no resources.
Nov 28 22:08:19 ps1 last message repeated 19 times
Nov 28 22:09:20 ps1 last message repeated 56 times
...
Nov 29 03:57:34 ps1 last message repeated 5 times
Nov 29 03:58:36 ps1 last message repeated 4 times
Nov 29 03:59:41 ps1 last message repeated 5 times
Nov 29 04:00:44 ps1 last message repeated 4 times
Nov 29 04:01:47 ps1 last message repeated 6 times
Nov 29 09:54:13 ps1 syslogd 1.4-0: restart.

Then me hitting the reset key before 10am.  I'm going to start digging
through the code (guess it will be more of a learning experience for
me rather then actually being able to help code).  So any suggestions
will be helpful.

---
Sven Heinicke <sven@research.nj.nec.com> Princeton, NJ
