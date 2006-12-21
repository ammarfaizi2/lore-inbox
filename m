Return-Path: <linux-kernel-owner+w=401wt.eu-S965165AbWLUJyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWLUJyz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWLUJyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:54:55 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4535 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965165AbWLUJyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:54:54 -0500
Date: Thu, 21 Dec 2006 09:54:33 +0000
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
Message-ID: <20061221095433.GC1994@flint.arm.linux.org.uk>
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
References: <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org> <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org> <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com> <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com> <20061220221141.GB13129@flint.arm.linux.org.uk> <20061221081845.GA4674@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221081845.GA4674@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 09:18:45AM +0100, Martin Michlmayr wrote:
> * Russell King <rmk+lkml@arm.linux.org.uk> [2006-12-20 22:11]:
> > > This patch doesn't fix my problem (apt segfaults on ARM because its
> > > database is corrupted).
> > 
> > Are you using IDE in PIO mode?  If so, the bug probably lies there.
> 
> I'm using usb-storage.  It's used to access an external IDE drive in
> an USB enclosure but I don't think it matters that it's IDE since
> we're using the SCSI layer to talk to it, right?

USB generally uses DMA so you're probably safe.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
