Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313555AbSDHFPK>; Mon, 8 Apr 2002 01:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313556AbSDHFPJ>; Mon, 8 Apr 2002 01:15:09 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:41632 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313555AbSDHFPI>; Mon, 8 Apr 2002 01:15:08 -0400
Date: Sun, 7 Apr 2002 23:14:57 -0600
Message-Id: <200204080514.g385EvS07821@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ns83820 0.17 (Re: Broadcom 5700/5701 Gigabit Ethernet Adapters)
In-Reply-To: <20020312004036.A3441@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise writes:
> On Sun, Mar 10, 2002 at 06:30:33PM -0800, David S. Miller wrote:
> > Syskonnect sk98 with jumbo frames gets ~107MB/sec TCP bandwidth
> > without NAPI, there is no reason other cards cannot go full speed as
> > well.
> > 
> > NAPI is really only going to help with high packet rates not with
> > thinks like raw bandwidth tests.
> 
> A day's tweaking later, and I'm getting 810mbit/s with netperf
> between two Athlons with default settings (1500 byte packets).  What
> I've found is that increasing the size of the RX/TX rings or the max
> sizes of the tcp r/wmem backlogs really slows things down, so I'm
> not doing that anymore.  The pair of P3s shows 262mbit/s (up from
> 67).

Just a public word of thanks to Ben for improving the driver. I've got
7 shiny new Addtron cards (aka "El Cheapo":-) and with 2.4.19-pre6 I'm
getting TCP bandwidths of 69 MB/s (PIII 450 SMP to Athalon 500 UP) and
52 MB/s (Athalon 500 UP to PIII 450 SMP). CONFIG_DEBUG_SLAB=n. This is
with two 16 m runs of Category 5 cable (still waiting for the Cat 6).
MTU=1500.

Only half of the theoretical bandwidth, but, hey, it's heaps better
than 100 Mb/s. Hopefully the remaining 50% will be reclaimed after
more hackery (and/or NAPI). Being on a mixed 10/100/1000 Mb/s network
means that I'm stuck with MTU=1500.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
