Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264795AbSJaIy0>; Thu, 31 Oct 2002 03:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264798AbSJaIy0>; Thu, 31 Oct 2002 03:54:26 -0500
Received: from netcore.fi ([193.94.160.1]:57614 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S264795AbSJaIyZ>;
	Thu, 31 Oct 2002 03:54:25 -0500
Date: Thu, 31 Oct 2002 10:55:56 +0200 (EET)
From: Pekka Savola <pekkas@netcore.fi>
To: Noriaki Takamiya <takamiya@po.ntts.co.jp>
cc: ajtuomin@morphine.tml.hut.fi, <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>,
       <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>,
       <yoshfuji@wide.ad.jp>, <torvalds@transmeta.com>, <jagana@us.ibm.com>
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
In-Reply-To: <20021031.174442.846937513.takamiya@po.ntts.co.jp>
Message-ID: <Pine.LNX.4.44.0210311053570.19356-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Noriaki Takamiya wrote:
> (2) Avoiding Netfilter Hooks
> 	In your imprementation HA uses netfilter to intercept packets
> 	sent to MN. We think it is costy so we have a suggestion to
> 	use FIB structure to forward packets to MN. Bacause we think
> 	forwarding packets from HA to MN is FORWARDING, not FILTERING.
> 	We think the kernel maintainers may prefer such a manner using
> 	FIB structure for forwarding.

Sounds sensible.
 
> (7) Source Address Selection of MN
> 	When host acts as MN, your implementation always select HoA as the
> 	source address. The source address should be a CoA. 

No, draft-ietf-ipv6-default-addr-select-09.txt Rule 4 says home addresses 
should be preferred, except via a possible API interaction.

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords

