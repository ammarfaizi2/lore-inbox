Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265468AbRF1BFF>; Wed, 27 Jun 2001 21:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbRF1BEz>; Wed, 27 Jun 2001 21:04:55 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:42458 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S265468AbRF1BEp>;
	Wed, 27 Jun 2001 21:04:45 -0400
Date: Thu, 28 Jun 2001 10:04:33 +0900 (JST)
Message-Id: <200106280104.f5S14XA05644@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: "David S. Miller" <davem@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <15162.32433.598824.599520@pizda.ninka.net>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
	<200106280007.f5S07qQ04446@mule.m17n.org>
	<20010628012349.L1554@redhat.com>
	<200106280041.f5S0fDr05278@mule.m17n.org>
	<15162.32433.598824.599520@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
 > The I/O completion must flush the cache, not the VM subsystem.
 > 
 > You must implement cache flushing at the DMA tranfer end point
 > to fix the problem you are describing.

Thanks a lot.  I understand now.  

Aha, that's the reason why we have __flush_dcache_range() in ide_insw
for Sparc64 implementation, isn't it?  I'll follow it for SuperH.

I'll close the entry for MM bugzilla, it's not MM bug.
-- 
