Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267501AbRG2CSR>; Sat, 28 Jul 2001 22:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbRG2CSH>; Sat, 28 Jul 2001 22:18:07 -0400
Received: from juicer39.bigpond.com ([139.134.6.96]:47835 "EHLO
	mailin8.bigpond.com") by vger.kernel.org with ESMTP
	id <S267501AbRG2CRw>; Sat, 28 Jul 2001 22:17:52 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 networking/routing slowdown 
In-Reply-To: Your message of "Thu, 26 Jul 2001 14:25:31 +0200."
             <20010726142531.G1024@informatics.muni.cz> 
Date: Sat, 28 Jul 2001 17:10:48 +1000
Message-Id: <E15QOFN-0007NI-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In message <20010726142531.G1024@informatics.muni.cz> you write:
> seconds to echo a single keystroke). I've figured out that ipchains.o in 2.4
> is linked with connection tracking, which probably causes the main slowdown.

Yes, you're paying for full connection tracking with the compatibility
stuff.  If you just want filtering, switch to iptables (should be
pretty easy for you).

> After rmmod ipchains the server seems to have its interactive performace
> back on normal speed, but routing performance still sucks: FTP between
> two hosts on different interfaces gets about 1600 KBytes/s (in 2.2 kernel
> it runs at 9900 KBytes/s). When I disable CONFIG_NET_HW_FLOWCONTROL,
> the throughput increases (ugh!) to 2300 KBytes/s.

Hmmm... this I don't know.

Rusty.
--
Premature optmztion is rt of all evl. --DK
