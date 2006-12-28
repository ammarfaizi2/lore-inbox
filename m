Return-Path: <linux-kernel-owner+w=401wt.eu-S1753456AbWL1MMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbWL1MMm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 07:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbWL1MMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 07:12:42 -0500
Received: from mail.cc.tut.fi ([130.230.1.120]:49753 "EHLO outbox.tut.fi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753456AbWL1MMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 07:12:41 -0500
X-Greylist: delayed 1321 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 07:12:41 EST
Date: Thu, 28 Dec 2006 13:50:36 +0200
From: Petri Kaukasoina <kaukasoina610meov7e@sci.fi>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Message-ID: <20061228115036.GA18216@elektroni.phys.tut.fi>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
	gordonfarquharson@gmail.com, tbm@cyrius.com,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
	Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
	nickpiggin@yahoo.com.au, arjan@infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061226.205518.63739038.davem@davemloft.net> <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net> <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 07:04:34PM -0800, Linus Torvalds wrote:
> [ Modified test-program that tells you where the corruption happens (and 
>   when the missing parts were supposed to be written out) appended, in 
>   case people care. ]

Hi

2.6.18 (and 2.6.18.6) is ok, 2.6.19-rc1 is broken. I tried some snapshots
between them but they hung before shell (2.6.18-git11, 2.6.18-git16,
2.6.18-git20, 2.6.18-git21). 2.6.18-git22 booted and was broken.

(UP, no preempt)

-Petri
