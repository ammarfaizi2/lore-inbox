Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSH0SfO>; Tue, 27 Aug 2002 14:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSH0SfO>; Tue, 27 Aug 2002 14:35:14 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11013 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316728AbSH0SfN>; Tue, 27 Aug 2002 14:35:13 -0400
Date: Tue, 27 Aug 2002 14:32:53 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: conman@kolivas.net
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM changes added to performance patches for 2.4.19
In-Reply-To: <1030170794.3d6728aa24046@kolivas.net>
Message-ID: <Pine.LNX.3.96.1020827142205.14697A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2002 conman@kolivas.net wrote:

> 
> With the patch against 2.4.19:
> 
> Scheduler O(1), Preemptible, Low Latency
> 
> I have now added two extra alternative patches that include 
> either Rik's rmap (thanks Rik) or AA's vm changes (thanks to Nuno Monteiro for
> merging this)
> 
> For the record, with the (very) brief usage of these two patches I found the
> rmap patch a little faster. This is very subjective and completely untested.
> 
> Check them out here and tell me what you think(please read the FAQ):
> http://kernel.kolivas.net

I tried the 2.4.19-ck3-aa patch last night, and did a few informal tests
against my current production kernel, 2.4.19-ac4. Machine in Athlon
1400MHz, 1GB RAM, 20+30GB WD disks.

Kernel compile was about 7 sec faster with ck3-aa, 6:58 vs 7:05 (no -j
values).

Then I did my nightly backup of a scanned documentation project, making a
CD image from the scans, currently ~570MB. I was on ck3-aa, and I said
"self, that seemed pretty fast!" So I rebooted cold and tried the mkisofs
with both kernels, twice each.

			2.4.19-ac4		2.4.19-ck3-aa
mkisofs 570MB		2:05			1:14

It was repeatably 40% faster! More testing, and now I'll build a stock
2.4.19 kernel for additional testing, and pull that responsiveness
benchmark and try that, too.

Looks like a nice job overall, I'm putting it on a laptop tonight, which
may give a better idea of how fast, or not, it really is.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

