Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbUK0Dw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUK0Dw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUK0DwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:52:23 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262521AbUKZTdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:38 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, dhowells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
	<orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
	<1101422103.19141.0.camel@localhost.localdomain>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 26 Nov 2004 09:42:53 -0200
In-Reply-To: <1101422103.19141.0.camel@localhost.localdomain>
Message-ID: <or3bywzvia.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 25, 2004, David Woodhouse <dwmw2@infradead.org> wrote:

> There's no _real_ need to keep them. All we need to fix is a handful of
> libc implementations; anything else using them was broken anyway.

It's not as simple as *fixing* them.  They'd have to go through a
transition period in which they support both formats, which probably
implies a mess of ifdefs or, worse, macro expansion in #include
directives.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
