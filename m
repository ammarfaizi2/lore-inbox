Return-Path: <linux-kernel-owner+w=401wt.eu-S1752789AbWL1O4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbWL1O4x (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 09:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbWL1O4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 09:56:53 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:37820 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbWL1O4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 09:56:53 -0500
Date: Thu, 28 Dec 2006 15:56:32 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       ranma@tdiedrich.de, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       andrei.popa@i-neo.ro, Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Message-ID: <20061228145632.GH4850@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net> <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org> <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com> <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org> <97a0a9ac0612272115g4cce1f08n3c3c8498a6076bd5@mail.gmail.com> <Pine.LNX.4.64.0612272120180.4473@woody.osdl.org> <97a0a9ac0612272138o5348488ahfde03f9e22a71b5d@mail.gmail.com> <20061228101659.GB14626@deprecation.cyrius.com> <20061228104923.GB20596@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228104923.GB20596@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King <rmk+lkml@arm.linux.org.uk> [2006-12-28 10:49]:
> > By the way, I just tried it with TARGETSIZE (100 << 12) on a different
> > ARM machine (a Thecus N2100 based on an IOP32x chip with 128 MB of
> > memory) and I see similar results to that from Gordon:
> 
> Work around the glibc memset() problem by passing nr & 255, and re-run
> the test.  You're getting false positives.

Yeah, I saw your message about this problem after I sent mine.
-- 
Martin Michlmayr
http://www.cyrius.com/
