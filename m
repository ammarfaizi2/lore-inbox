Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265000AbSJWNnX>; Wed, 23 Oct 2002 09:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265004AbSJWNnX>; Wed, 23 Oct 2002 09:43:23 -0400
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:53925 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S265000AbSJWNnW>; Wed, 23 Oct 2002 09:43:22 -0400
Date: Wed, 23 Oct 2002 15:49:31 +0200
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: linux-kernel@vger.kernel.org
Subject: via-rhine weirdness with via kt8235 Southbridge
Message-ID: <20021023154931.E14930@pc9391.uni-regensburg.de>
References: <20021023154824.C14930@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021023154824.C14930@pc9391.uni-regensburg.de>; from christian.guggenberger@physik.uni-regensburg.de on Wed, Oct 23, 2002 at 15:48:24 +0200
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I like to report some Problems with the NIC integrated in the via kt8235 
chipset.
(Mobo is a Epox 8k5a3+, network is 10 MBit half-duplex)

1.
This concerns both 2.4 and 2.5 kernels  (testet with 2.4.20pre*aa series, and 
with 2.5.43, 2.5.44 and 2.5.44-ac1):

When I enable APIC in the Bios, the via-rhine module will insert properly, but 
I won't get a link... With APIC disabled, link is ok.
Ok, this could be caused by buggy bios, so I'll try again, when a new 
biosversion is available.

2.
This only happens with the 2.5 series (testet with 2.5.43 and above):
When there's much flow on the nic, I get many timeouts ending in dead NIC and 
I've to reboot...

Oct 23 14:56:45 bonnie79 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 23 14:56:45 bonnie79 kernel: eth0: Transmit timed out, status 0000, PHY 
status 786d, resetting...
Oct 23 14:56:49 bonnie79 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 23 14:56:49 bonnie79 kernel: eth0: Transmit timed out, status 0000, PHY 
status 786d, resetting...
Oct 23 14:56:59 bonnie79 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 23 14:56:59 bonnie79 kernel: eth0: Transmit timed out, status 0000, PHY 
status 786d, resetting...

I remember a discussion (Sep. 26th, I think), where such problems had been 
reported for the 2.4.20pre kernels.... which now seem to be fixed in the 
latest 2.4 series.

Christian
  
