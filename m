Return-Path: <linux-kernel-owner+w=401wt.eu-S1161005AbWLUMav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWLUMav (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 07:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWLUMav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 07:30:51 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2484 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030265AbWLUMau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 07:30:50 -0500
Date: Thu, 21 Dec 2006 12:30:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061221123022.GA10775@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Gordon Farquharson <gordonfarquharson@gmail.com>,
	Martin Michlmayr <tbm@cyrius.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Hugh Dickins <hugh@veritas.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Florian Weimer <fw@deneb.enyo.de>,
	Marc Haber <mh+linux-kernel@zugschlus.de>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
References: <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com> <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com> <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com> <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org> <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 11:53:25PM -0800, Linus Torvalds wrote:
> That's obviously a bug worth fixing on its own. Do you know when it 
> started?

My last merge, just before 2.6.19-rc1.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
