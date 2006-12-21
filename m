Return-Path: <linux-kernel-owner+w=401wt.eu-S1422899AbWLUPsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422899AbWLUPsN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 10:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422916AbWLUPsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 10:48:13 -0500
Received: from [85.204.20.254] ([85.204.20.254]:45117 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422899AbWLUPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 10:48:11 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
In-Reply-To: <Pine.LNX.4.64.0612201622480.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	 <1166622979.10372.224.camel@twins>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <20061220153207.b2a0a27f.akpm@osdl.org>
	 <Pine.LNX.4.64.0612201548410.3576@woody.osdl.org>
	 <20061220161158.acb77ce6.akpm@osdl.org>
	 <Pine.LNX.4.64.0612201615590.3576@woody.osdl.org>
	 <Pine.LNX.4.64.0612201622480.3576@woody.osdl.org>
Content-Type: text/plain
Organization: I-NEO
Date: Thu, 21 Dec 2006 17:48:01 +0200
Message-Id: <1166716081.6901.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 16:24 -0800, Linus Torvalds wrote:
> 
> Btw, I'd really love to hear whether the patch I sent out actually _helps_ 
> at all, or whether we're just discussing something that in the end is just 
> a cleanup..
> 
> Martin, Peter, Andrei, pls give it a try. (Martin and Andrei may be 
> talking about different bugs, so _both_ of your experiences definitely 
> matter here).

with http://lkml.org/lkml/diff/2006/12/20/204/1
I have corruption: Hash check on download completion found bad chunks,
consider using "safe_sync".

> 
> 		Linus

