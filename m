Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbTDALiQ>; Tue, 1 Apr 2003 06:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262408AbTDALiQ>; Tue, 1 Apr 2003 06:38:16 -0500
Received: from ns.suse.de ([213.95.15.193]:2058 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262406AbTDALiL>;
	Tue, 1 Apr 2003 06:38:11 -0500
Subject: Re: [PATCH][2.5][RFT] sfence wmb for K7,P3,VIAC3-2(?)
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030401112800.GA23027@suse.de>
References: <Pine.LNX.4.50.0304010242250.8773-100000@montezuma.mastecende.com>
	<Pine.LNX.4.50.0304010320220.8773-100000@montezuma.mastecende.com>
	<1049191863.30759.3.camel@averell>  <20030401112800.GA23027@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Apr 2003 13:49:32 +0200
Message-Id: <1049197774.31041.15.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-01 at 13:28, Dave Jones wrote:
> On Tue, Apr 01, 2003 at 12:11:00PM +0200, Andi Kleen wrote:
>  > sfence is part of SSE2. That's X86_SSE2
> 
> I'm not so sure this is correct. A quick google suggests
> otherwise, and the C3 Nehemiah (which only supports SSE1) seems
> to run sfence instructions just fine.

Yes, you're correct. It was SSE1, not SSE2.

The problem Zwane encountered is that early Athlons don't support SSE1,
only XP+ do

To use it he would need an a new CONFIG split for Athlon XP and earlier
Athlon. iirc it didn't make much difference on the athlon anyways which
has quite fast locked operations on exclusive cachelines - sfence seems
to be more useful on P4.

-Andi


