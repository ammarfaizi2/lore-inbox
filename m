Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276229AbRJGKjG>; Sun, 7 Oct 2001 06:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276234AbRJGKi4>; Sun, 7 Oct 2001 06:38:56 -0400
Received: from c999639-a.carneg1.pa.home.com ([24.180.243.111]:59642 "EHLO
	maul.jdc.home") by vger.kernel.org with ESMTP id <S276229AbRJGKij>;
	Sun, 7 Oct 2001 06:38:39 -0400
Subject: AIC7xxx panic
From: Jim Crilly <noth@noth.is.eleet.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 07 Oct 2001 06:37:30 -0400
Message-Id: <1002451051.3718.20.camel@warblade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a reproducible panic while running dbench simulating 25+ clients,
the new aic7xxx driver panics with "Too few segs for dma mapping.
"Increase AHC_NSEG". The partition in question is FAT32 and on a
different disk than /, I'm not using HIGHMEM. I am using XFS and the
preempt patches, but I don't think they're related to the panic.

The odd thing, is if I run dbench in the same manner on my / partition,
which is on a different disk on the same controller, it goes fine. It
seems, to my untrained eye anyway, to be a bad interaction between the
vfat driver and the aic7xxx driver.

I'm using the old aic7xxx driver right now and it's fine, has anyone
else seen anything like this?

Jim
-- 
Help protect your rights on-line.
Join the Electronic Frontiers Foundation today: http://www.eff.org/join
-----------------------------------------------------------------------
Security: Antonyms: See Microsoft
-----------------------------------------------------------------------
"We are coming after you. God may have mercy on you, but we won't,"
declared Sen. John McCain, R-Arizona.

