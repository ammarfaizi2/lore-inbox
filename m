Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268511AbTANCgO>; Mon, 13 Jan 2003 21:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268523AbTANCgO>; Mon, 13 Jan 2003 21:36:14 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:43750 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S268511AbTANCgM>; Mon, 13 Jan 2003 21:36:12 -0500
Date: Mon, 13 Jan 2003 21:49:49 -0500
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA disabled with via82cxxx on kernels >= 2.5.35
Message-ID: <20030114024949.GA165@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Recent 2.5 kernels boot with "DMA disabled".

> It turns it on again but forgets to tell you. Its on the fix list
> but for 2.4 first

Actual throughput on Athlon is better then hdparm lets on.  A 
dd test on 2.5.53-mm1 shows about 120 MB/sec for a file that fits in 
memory.

# time dd if=/dev/zero of=/tmp/junk bs=4M count=100
100+0 records in
100+0 records out

real    0m3.312s
user    0m0.002s
sys     0m3.267s

# ls -lh /tmp/junk
-rw-r--r--    1 root     root         400M Jan 13 21:43 /tmp/junk

hdparm -tT on the K6/2 shows similar throughput between 2.4 and 2.5.

Maybe my hdparm is just wacky on 2.5.  

2.4.20-pre3-jam1:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.70 seconds =182.86 MB/sec
 Timing buffered disk reads:  64 MB in  2.07 seconds = 30.92 MB/sec

2.5.53-mm1

/dev/hda:
 Timing buffer-cache reads:   128 MB in  7.20 seconds = 17.78 MB/sec
 Timing buffered disk reads:  64 MB in 19.66 seconds =  3.26 MB/sec

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

