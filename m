Return-Path: <linux-kernel-owner+w=401wt.eu-S1030356AbWLTWML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWLTWML (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWLTWMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:12:10 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3832 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030356AbWLTWMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:12:09 -0500
Date: Wed, 20 Dec 2006 22:11:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hugh@veritas.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrei Popa <andrei.popa@i-neo.ro>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061220221141.GB13129@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Michlmayr <tbm@cyrius.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Hugh Dickins <hugh@veritas.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Florian Weimer <fw@deneb.enyo.de>,
	Marc Haber <mh+linux-kernel@zugschlus.de>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	gordonfarquharson@gmail.com
References: <1166471069.6940.4.camel@localhost> <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org> <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org> <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com> <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220170323.GA12989@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 06:03:23PM +0100, Martin Michlmayr wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> [2006-12-20 14:56]:
> > page_mkclean_one() fix
> 
> This patch doesn't fix my problem (apt segfaults on ARM because its
> database is corrupted).

Are you using IDE in PIO mode?  If so, the bug probably lies there.

As I've said repeatedly when asked by IDE folk to test their PIO-based
cache coherency fixes, I am unable to reproduce the bug, ergo I am
unable to test the fix.

(Some people, such as Jeff Garzik to name names, took that as me being
entirely unreasonable and un-cooperative.  But consider carefully - how
can _anyone_ test something that they can't produce.  I consider Jeff's
comments extremely very childish in that respect.)

Hence, as far as I'm aware, Linux on PIO-based IDE ARM hardware remains
utterly *unsafe*.

Sorry.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
