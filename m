Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265465AbRGBWse>; Mon, 2 Jul 2001 18:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265464AbRGBWsY>; Mon, 2 Jul 2001 18:48:24 -0400
Received: from [216.101.162.242] ([216.101.162.242]:63686 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S265484AbRGBWsO>;
	Mon, 2 Jul 2001 18:48:14 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15168.64008.256248.834586@pizda.ninka.net>
Date: Mon, 2 Jul 2001 15:47:36 -0700 (PDT)
To: NIIBE Yutaka <gniibe@m17n.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Cache issues
In-Reply-To: <200107021123.f62BNwj02290@mule.m17n.org>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
	<200106280007.f5S07qQ04446@mule.m17n.org>
	<20010628012349.L1554@redhat.com>
	<200106280041.f5S0fDr05278@mule.m17n.org>
	<15162.32433.598824.599520@pizda.ninka.net>
	<200106280104.f5S14XA05644@mule.m17n.org>
	<200106291418.f5TEI0i09541@mule.m17n.org>
	<200107021123.f62BNwj02290@mule.m17n.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NIIBE Yutaka writes:
 > I've looked thorough all flush_page_to_ram and flush_icache_page calls.
 > If the architecture support follows the rule of Documentation/cachetlb.txt, 
 > I think that all the occurrences of flush_page_to_ram and
 > flush_icache_page are (almost) bogus now.

Unfortunately several ports still use the old calls and do not make
use of flush_dcache_page etc.

So these older intefaces may not be arbitrarily removed in 2.4.x

The goal is to eventually remove them, this is true.  But it must
be done in 2.5.x at the earliest.

Later,
David S. Miller
davem@redhat.com
