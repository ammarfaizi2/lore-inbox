Return-Path: <linux-kernel-owner+w=401wt.eu-S932787AbWL1Ja7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbWL1Ja7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWL1Ja7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:30:59 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:37267 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932787AbWL1Ja6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:30:58 -0500
Date: Thu, 28 Dec 2006 10:30:41 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       ranma@tdiedrich.de, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       andrei.popa@i-neo.ro, Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Message-ID: <20061228093041.GA14626@deprecation.cyrius.com>
References: <20061226.205518.63739038.davem@davemloft.net> <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net> <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org> <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com> <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org> <97a0a9ac0612272115g4cce1f08n3c3c8498a6076bd5@mail.gmail.com> <Pine.LNX.4.64.0612272120180.4473@woody.osdl.org> <97a0a9ac0612272138o5348488ahfde03f9e22a71b5d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a0a9ac0612272138o5348488ahfde03f9e22a71b5d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gordon Farquharson <gordonfarquharson@gmail.com> [2006-12-27 22:38]:
> >That's just 400kB!
> >
> >There's no way you should see corruption with that kind of value. It
> >should all stay solidly in the cache.
> >
> >Is this perhaps with ARM nommu or something else strange? It may be that
> >the program just doesn't work at all if mmap() is faked out with a malloc
> >or similar.
> 
> Definitely a question for the ARM gurus. I'm out of my depth.

The CPU has a MMU.  For reference, it's a IXP4xx based device with 32 MB
of memory.
-- 
Martin Michlmayr
http://www.cyrius.com/
