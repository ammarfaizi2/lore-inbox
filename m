Return-Path: <linux-kernel-owner+w=401wt.eu-S1751219AbWLVRLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWLVRLb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWLVRLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:11:31 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:54575 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbWLVRLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:11:30 -0500
Date: Fri, 22 Dec 2006 18:11:13 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061222171113.GC4229@deprecation.cyrius.com>
References: <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> <20061222100004.GC10273@deprecation.cyrius.com> <20061222100637.GA12105@deprecation.cyrius.com> <20061222101055.GA12230@deprecation.cyrius.com> <97a0a9ac0612220730r4f00c913k65a074097f981277@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a0a9ac0612220730r4f00c913k65a074097f981277@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gordon Farquharson <gordonfarquharson@gmail.com> [2006-12-22 08:30]:
> Based on the kernel gurus current knowledge of the problem, would
> you expect the corruption to occur at the same point in a file, or
> is it possible that the corruption could occur at different points
> on successive Debian installer attempts on a UP, non PREEMPT system?

Seems like it can occur anywhere.  In fact, some people see apt
problems because of filesystem corruption on the NSLU2 after they have
already installe Debian.  I've only seen this once myself and failed
many times to find a reproducible situation.
-- 
Martin Michlmayr
http://www.cyrius.com/
