Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWEOSOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWEOSOX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEOSOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:14:22 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:61883 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965025AbWEOSOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:14:20 -0400
Date: Mon, 15 May 2006 20:14:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060515181413.GA18652@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org> <20060515140811.GA23750@shadowen.org> <20060515175306.GA18185@elte.hu> <200605152001.16813.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605152001.16813.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > i still strongly oppose the original Andi hack... numerous reasons were 
> > given not to apply it (it's nice to simulate/trigger rarer features on 
> > mainstream hardware too, and this ability to boot NUMA on my flat x86 
> > testbox found at least one other NUMA bug already). Furthermore, the 
> > crash i reported was fixed by the NUMA patchset. Andrew, please drop:
> 
> The problem is that it's not regularly used on a wide range of boxes 
> so it will eventually break again. We had this cycle several times 
> already.

so it will find new bugs. Since you wrote that patch the ability to try 
numa on 'flat' x86 hardware has found two bugs, one of which (the zone 
alignment thing) could very well affect non-obsolete hardware too.

Andi, triggering bugs as widely as possible is the _whole point_ of QA 
and diversity of testing! Do you disable the compilation of the floppy 
driver just because it's obsolete hardware? Will you remove NUMA 
emulation from x86_64 just because it regularly broke in the past?

Fact is, the more hardware a given feature can be tried on, the better 
tested that feature becomes. I find it quite extreme that this point has 
to even be argued...

	Ingo
