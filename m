Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264214AbRFDMQE>; Mon, 4 Jun 2001 08:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264193AbRFDKy4>; Mon, 4 Jun 2001 06:54:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37018 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264001AbRFDKyq>;
	Mon, 4 Jun 2001 06:54:46 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15131.26866.794001.525719@pizda.ninka.net>
Date: Mon, 4 Jun 2001 03:54:42 -0700 (PDT)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: multicast hash incorrect on big endian archs
In-Reply-To: <3B1B564E.D83A741A@colorfullife.com>
In-Reply-To: <3B1A9558.2DBAECE7@colorfullife.com>
	<15130.61778.471925.245018@pizda.ninka.net>
	<3B1B3268.2A02D2C@colorfullife.com>
	<3B1B564E.D83A741A@colorfullife.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul writes:
 > That could cause alignment problems.
 > <<< from starfire.c
 > {
 >      long filter_addr;
 >      u16 mc_filter[32] __attribute__ ((aligned(sizeof(long)))); 
 > <<<
 > set_bit requires word alignment, but without the __attibute__ the
 > compiler would only guarantee 16-bit alignment. IMHO ugly.

Correction, it requires "long" alignment and that is 64-bits
on several platforms.

Later,
David S. Miller
davem@redhat.com
