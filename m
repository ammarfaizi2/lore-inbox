Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132137AbRDNNCv>; Sat, 14 Apr 2001 09:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132140AbRDNNCl>; Sat, 14 Apr 2001 09:02:41 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:1294 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132137AbRDNNCV> convert rfc822-to-8bit; Sat, 14 Apr 2001 09:02:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Peter <ujq7@rz.uni-karlsruhe.de>
To: linux-kernel@vger.kernel.org
Subject: Re: SW-RAID0 Performance problems
Date: Sat, 14 Apr 2001 15:09:37 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10104131048550.1669-100000@coffee.psychology.mcmaster.ca> <01041411380600.00516@debian> <20010414142839.A12760@ping.be>
In-Reply-To: <20010414142839.A12760@ping.be>
MIME-Version: 1.0
Message-Id: <01041415093700.01502@debian>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 14. April 2001 14:28 schrieb Kurt Roeckx:
> Does turning unmaskirq on help?

Already tried this, but it doesn't help
The actual settings (same on /dev/hdc):

bash-2.04# hdparm /dev/hda
 
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 59556/16/63, sectors = 60032448, start = 0

bash-2.04# hdparm -tT /dev/md0
 
/dev/md0:
 Timing buffer-cache reads:   128 MB in  1.30 seconds = 98.46 MB/sec
 Timing buffered disk reads:  64 MB in  3.14 seconds = 20.38 MB/sec

bash-2.04# hdparm -tT /dev/hda3
 
/dev/hda3:
 Timing buffer-cache reads:   128 MB in  1.31 seconds = 97.71 MB/sec
 Timing buffered disk reads:  64 MB in  2.26 seconds = 28.32 MB/sec

Andreas
-- 
Andreas Peter *** ujq7@rz.uni-karlsruhe.de

