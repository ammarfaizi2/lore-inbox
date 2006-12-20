Return-Path: <linux-kernel-owner+w=401wt.eu-S1030197AbWLTRgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWLTRgv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 12:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWLTRgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 12:36:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51365 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030197AbWLTRgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 12:36:41 -0500
Date: Wed, 20 Dec 2006 09:35:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Michlmayr <tbm@cyrius.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hugh@veritas.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <20061220170323.GA12989@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
References: <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
 <1166471069.6940.4.camel@localhost> <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
 <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
 <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org>
 <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
 <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Martin Michlmayr wrote:

> * Peter Zijlstra <a.p.zijlstra@chello.nl> [2006-12-20 14:56]:
> > page_mkclean_one() fix
> 
> This patch doesn't fix my problem (apt segfaults on ARM because its
> database is corrupted).

Can you remind us:
 - your ARM is UP, right? Do you have PREEMPT on?
 - This is probably a stupid question, but you did make sure that the 
   database was ok (with some rebuild command) and that you didn't have 
   preexisting corruption?

Anyway, the page_mkclean_one() fixes (along with _most_ things we've 
looked at) shouldn't matter on UP, at least certainly not without PREEMPT.

		Linus
