Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbRGMTGb>; Fri, 13 Jul 2001 15:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbRGMTGV>; Fri, 13 Jul 2001 15:06:21 -0400
Received: from yap.isi.edu ([128.9.160.146]:12933 "EHLO yap.isi.edu")
	by vger.kernel.org with ESMTP id <S267528AbRGMTGH>;
	Fri, 13 Jul 2001 15:06:07 -0400
To: linux-kernel@vger.kernel.org
Subject: multicasting: IP_MULTICAST_LOOP & ttl==0 bug?
From: Yuri <yuri@ISI.EDU>
Date: 13 Jul 2001 12:06:08 -0700
Message-ID: <xtjk81c8x9b.fsf@yap.isi.edu>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I seem to have found out that depending on whether or not multicast
loopback is enabled outgoing multicast packets with ttl set to 0 are
treated differently.  

In both cases I set ttl of outgoing packets to 0 (with
IP_MULTICAST_TTL setsockopt).  If multicast loop is enabled, packets
remain local for the machine and are not sent onto the wire (expected
behavior).  However, if I disable multicast loopback, packets with ttl
0 show up on the wire.  Is this a bug or I'm missing something?

Kernel version is 2.4.3-12.

Thanks,

  -Yuri

P.S.  Please CC.
