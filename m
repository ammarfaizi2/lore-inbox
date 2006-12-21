Return-Path: <linux-kernel-owner+w=401wt.eu-S965172AbWLUJ1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWLUJ1t (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWLUJ1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:27:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52286 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965172AbWLUJ1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:27:48 -0500
Date: Thu, 21 Dec 2006 01:27:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Gordon Farquharson" <gordonfarquharson@gmail.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Martin Michlmayr" <tbm@cyrius.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       "Arnd Bergmann" <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
Message-Id: <20061221012721.68f3934b.akpm@osdl.org>
In-Reply-To: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	<1166622979.10372.224.camel@twins>
	<20061220170323.GA12989@deprecation.cyrius.com>
	<Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	<20061220175309.GT30106@deprecation.cyrius.com>
	<Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	<Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	<97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
	<Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
	<97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 02:17:05 -0700
"Gordon Farquharson" <gordonfarquharson@gmail.com> wrote:

> Can the call to task_io_account_cancelled_write() simply be removed
> from cancel_dirty_page() for testing the patch with 2.6.19 (since
> 2.6.19 doesn't seem to have the task I/O accounting) ?

Yes.
