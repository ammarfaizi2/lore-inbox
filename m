Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272209AbRIOKXZ>; Sat, 15 Sep 2001 06:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272219AbRIOKXP>; Sat, 15 Sep 2001 06:23:15 -0400
Received: from co3000407-a.belrs1.nsw.optushome.com.au ([203.164.252.88]:50363
	"EHLO bozar") by vger.kernel.org with ESMTP id <S272209AbRIOKXG>;
	Sat, 15 Sep 2001 06:23:06 -0400
Date: Sat, 15 Sep 2001 20:23:14 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: massive sched latency (even with akpm and rml's patches)
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Message-Id: <1000549394.284238.2074.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i'm getting (regular) latencies of up to 30ms on various
kernels, even with Andrew Morton low-latency patches and Nigel
Gamble/Robert Love's kernel pre-emption patches.

i'm running a Toshiba Satellite Pro 4280XDVD laptop, with 256MB
of RAM, and an IBM TravelStar 20GB hard disk.  the hard disk has
been 'tuned' (hdparm -m16 -c1 -u1 -d1 -k1 -S10 -X66), and for
akpm's patch, cat /proc/sys/kernel/lowlatency shows 1.  i'm
using Benno Senoner's latencytest progam, and i've tried using
the binary straight out of his .tar.gz archive as well as
compiling my own.  i've unloaded the pcmcia, usb and apm modules
on some of the tests as well, since i thought they might be
causing additional latency.  i'm using the ALSA snd-card-ymfpci
driver for sound output.  reiserfs is being used for the
partition which the latencytest is running on.

latencytest results are at

    http://www.algorithm.com.au/hacking/linux-lowlatency

kernels marked with 'll' have Andrew Morton's lowlatency patches
applied, and kernels marked with 'pe' have the patches from the
Linux Kernel Preemption Project applied.

any hints?  i've got about 500k left on my / partition thanks to
massive amount of kernel modules and kernels i've got installed
:).  i'm willing to do some hacking to the source, but i'm not
sure where to start tracking down the problem at the moment. 
thanks in advance!


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
