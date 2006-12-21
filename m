Return-Path: <linux-kernel-owner+w=401wt.eu-S1422850AbWLUIS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422850AbWLUIS7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422841AbWLUIS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:18:59 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:50418 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422842AbWLUIS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:18:58 -0500
Date: Thu, 21 Dec 2006 09:18:45 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: rmk+lkml@arm.linux.org.uk, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrei Popa <andrei.popa@i-neo.ro>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061221081845.GA4674@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org> <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org> <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com> <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com> <20061220221141.GB13129@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220221141.GB13129@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King <rmk+lkml@arm.linux.org.uk> [2006-12-20 22:11]:
> > This patch doesn't fix my problem (apt segfaults on ARM because its
> > database is corrupted).
> 
> Are you using IDE in PIO mode?  If so, the bug probably lies there.

I'm using usb-storage.  It's used to access an external IDE drive in
an USB enclosure but I don't think it matters that it's IDE since
we're using the SCSI layer to talk to it, right?
-- 
Martin Michlmayr
http://www.cyrius.com/
