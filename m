Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBGQWX>; Wed, 7 Feb 2001 11:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbRBGQWO>; Wed, 7 Feb 2001 11:22:14 -0500
Received: from lama.supermedia.pl ([212.75.96.18]:44302 "EHLO
	lama.supermedia.pl") by vger.kernel.org with ESMTP
	id <S129031AbRBGQV5>; Wed, 7 Feb 2001 11:21:57 -0500
Date: Wed, 7 Feb 2001 17:21:53 +0100
From: Bartek Krajnik <bartek@sm.pl>
To: linux-kernel@vger.kernel.org
Subject: alpha with 2.4.1
Message-ID: <20010207172153.A7333@lama.supermedia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My console after panic:
_____________________________________________________________________________
Code: b26901cc stl a3,460(s0)

 a0300000	ldl t0,0(a0)
 482010c1	extbl t0,0,t0
 402075a2	cmpeq t0,3,t1
 e4400003	blt t1,.+16
 d3400045	bsr ra,.+280
*b0090218	stl v0,536(s0)
 c3e00002	br .+12

Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
_____________________________________________________________________________

My cpuinfo:
______________________________________________________________________________
cpu                     : Alpha
cpu model               : EV56
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Noritake
system variation        : 0
system revision         : 0
system serial number    : AY90560615
cycle frequency [Hz]    : 500000000
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 994.44
kernel unaligned acc    : 318104 (pc=fffffc00003cec04,va=fffffc000e1c25e6)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : AlphaServer 800 5/500
cpus detected           : 1
______________________________________________________________________________

With kernel 2.2.* I haven't any problems... (expect files >2GB).
I use reiserfs(ext2: problem with inodes numbers) for /var/spool_news/.

-- 
	BARTEK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
