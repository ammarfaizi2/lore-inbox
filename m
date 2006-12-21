Return-Path: <linux-kernel-owner+w=401wt.eu-S1422823AbWLUHyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbWLUHyR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422825AbWLUHyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:54:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46882 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422823AbWLUHyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:54:16 -0500
Date: Wed, 20 Dec 2006 23:53:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> 
 <1166607554.3365.1354.camel@laptopd505.fenrus.org>  <1166614001.10372.205.camel@twins>
  <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com> 
 <1166622979.10372.224.camel@twins>  <20061220170323.GA12989@deprecation.cyrius.com>
  <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> 
 <20061220175309.GT30106@deprecation.cyrius.com>  <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
  <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
 <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Dec 2006, Gordon Farquharson wrote:
> 
> Unfortunately, I cannot get the latest git version of the kernel to
> boot on the ARM machine on which Martin and I are experiencing the apt
> segfault.

Ouch.

> After the kernel is finished uncompressing it prints "done,
> booting the kernel." as expected, but nothing more happens. I have
> tried both with and without the patch. Hopefully either Andrei or
> Martin will have better luck at testing this patch than I have had.

That's obviously a bug worth fixing on its own. Do you know when it 
started?

That said, I think the patch I sent out should actually work on top of 
plain 2.6.19 too. I don't think things have changed in this area that 
much. IOW, you don't _need_ latest -git to test it, you just need a broken 
kernel ;)

		Linus
