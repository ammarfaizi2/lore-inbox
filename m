Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbTE0T5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbTE0T5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:57:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25763 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264105AbTE0T5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:57:24 -0400
Date: Tue, 27 May 2003 17:08:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
In-Reply-To: <20030527200339.GI3767@dualathlon.random>
Message-ID: <Pine.LNX.4.55L.0305271707370.9487@freak.distro.conectiva>
References: <3ED2DE86.2070406@storadinc.com> <200305271952.34843.m.c.p@wolk-project.de>
 <Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva>
 <200305272004.02376.m.c.p@wolk-project.de> <20030527182547.GG3767@dualathlon.random>
 <Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva>
 <20030527200339.GI3767@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Andrea Arcangeli wrote:

> > It seems your "fix-pausing" patch is fixing a potential wakeup
> > miss, right? (I looked quickly throught it). Could you explain me the
>
> yes, not just one but multiple of them, all similar. lots of boxes were
> hanging in a weird manner until I found and fixed this glitch.
>
> > problem its trying to fix and how?
>
> I'm attaching the old email, it should have all the explanataions.
>
> but don't use that old patch (that was the first revision and it missed
> one last race in wait_for_request noticed by Chris or Andrew [or
> both?]), use this one instead (seems just the second revision, should be
> that one plus that last race fix):
>
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc2aa1/9980_fix-pausing-2

I wonder if the additional wakeups result in performance degradation (not
that it matters much in case there is no other way to fix the problem).

But anyway I would like to have some numbers with/without the patch.

Do you have them ?
