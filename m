Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317629AbSGJV1T>; Wed, 10 Jul 2002 17:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317632AbSGJV1S>; Wed, 10 Jul 2002 17:27:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61703 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317629AbSGJV1R>;
	Wed, 10 Jul 2002 17:27:17 -0400
Message-ID: <3D2CA6E3.CB5BC420@zip.com.au>
Date: Wed, 10 Jul 2002 14:28:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:
> 
> I'd like to see HZ closer to 100 than 1000, for CPU power reasons. Processor
> power states like C3 may take 100 microseconds+ to enter/leave - time when
> both the CPU isn't doing any work, but still drawing power as if it was. We
> pop out of C3 whenever there is an interrupt, so reducing timer interrupts
> is good from a power standpoint by amortizing the transition penalty over a
> longer period of power savings.

That makes a ton of sense.

> But on the other hand, increasing HZ has perf/latency benefits, yes? Have
> these been quantified?

Not that I'm aware of.  And I'd regard any such claims with some
scepticism.

> I'd either like to see a HZ that has balanced
> power/performance, or could we perhaps detect we are on a system that cares
> about power (aka a laptop) and tweak its value at runtime?

It's all rather fishy.

-
