Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281235AbRKPI0Q>; Fri, 16 Nov 2001 03:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281240AbRKPI0G>; Fri, 16 Nov 2001 03:26:06 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:63760 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281235AbRKPIZx>; Fri, 16 Nov 2001 03:25:53 -0500
Message-ID: <3BF4CD71.DD691BCC@zip.com.au>
Date: Fri, 16 Nov 2001 00:25:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: low-latency patch for 2.4.15-pre5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A low-latency scheduling patch for 2.4.15-pre4/pre5 is at

	http://www.zip.com.au/~akpm/linux/schedlat.html#downloads

This is a general retune, retest and review.  A couple of bugs which
have crept into the patch were fixed.  ext3 support is added. Certain
code paths which were introduced into the kernel in the 2.4.9-2.4.11
timeframe have been addressed.

On a single 850MHz PIII with 768 megs of RAM and 1G of swap the worst case interrupt-to-activation scheduling latency is around 400 microseconds.
Latencies on SMP are up to 1000 microseconds.

These measurements are across extreme workloads - peak latency across an SMP
kernel build is 260 microseconds.

-
