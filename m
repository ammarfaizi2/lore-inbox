Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTE0SZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbTE0SYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:24:50 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:34310 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264104AbTE0SX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:23:27 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 20:35:33 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <200305272004.02376.m.c.p@wolk-project.de> <20030527182547.GG3767@dualathlon.random>
In-Reply-To: <20030527182547.GG3767@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305272032.03645.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 20:25, Andrea Arcangeli wrote:

Hi Andrea,

> not exactly decreases I/O throughput, the latest I/O benchmarks I seen
it decreases performance. I've seen this, Con also saw this (well it's better 
than the 'nr_requests = 4' change ;) but mouse stops are still there.

> from Randy (dbench/tiotest/bonnie/etc..) were still the fastest and it
> included the lowlatency elevator patch. So it may not help latency but
> it doesn't hurt in the numbers, at least not in the high end (that in
> theory is the one that needs the overkill length in the I/O queue most).
I agree with the last sentence, in theory, but practice showed something 
different (about 10% to 15% performance decrease)

But I am quite sure that this depends on your machine/hardware. Using IDE 
instead of SCSI for example.

> However it definitely helps latency for me and I had a number of
> positive reports.
It helps but it's not as good as 2.4.18 stock.

> Also make sure that you elvtune -r 0 -w 0 /dev/hda, also the journaling
I also tried that.

> may affect the latency so you can try with plain ext2 to be sure it's
> not a fs issue.
Sure, I did this too. FS independent, where ReiserFS is still the best for 
this scenario with the most few pauses than any other FS (ext2, ext3, ...)

But for desktop usage: not acceptable! No way, No go!

> the lowlatency elevator patch may not be perfect but it definitely seems
> to work better here. especially since there's no apparent throughput
> loss, it makes lots of sense to keep it applied, or it would waste lots
> of ram for apparently no gain.
hehe, well wasting RAM for no gain is my next part on my todo ;) (cache 
everything even if there is no RAM for example, well but this is not the 
point in this thread)

ciao, Marc

