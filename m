Return-Path: <linux-kernel-owner+w=401wt.eu-S1946037AbWLVLIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946037AbWLVLIG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 06:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946039AbWLVLIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 06:08:06 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:53771 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946037AbWLVLIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 06:08:05 -0500
Date: Fri, 22 Dec 2006 12:07:47 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061222110747.GA13793@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> <20061222100004.GC10273@deprecation.cyrius.com> <20061222100637.GA12105@deprecation.cyrius.com> <20061222101055.GA12230@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222101055.GA12230@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Michlmayr <tbm@cyrius.com> [2006-12-22 11:10]:
> > immediately when I started wget, the hanging apt-get process
> > continued.
> ... and now that we've completed this step, the apt cache has suddenly
> been reduced (see Gordon's mail for an explanation) and it segfaults:

One of my questions was why apt-get worked to install the
initramfs-tools, the kernel and some other packages but later hung
while it was building the cache (which clearly it had built already to
install some packages): before the installer offers to install
additional packages, it changes the apt sources, which leads to apt
rebuilding the cache, and here it hangs.

Remember how I said that downloading a file with wget prompts apt to
work again?  Apparently any filesystem access will do (I just ran
find / > /dev/null).  Gordon, can you confirm this?
-- 
Martin Michlmayr
http://www.cyrius.com/
