Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268314AbUIGSYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbUIGSYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUIGSXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:23:31 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:47182 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268372AbUIGSUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:20:40 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/1] uml: no extraversion in arch/um/Makefile for mainline
Date: Tue, 7 Sep 2004 20:16:01 +0200
User-Agent: KMail/1.6.1
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <20040906173524.EE034B977@zion.localdomain> <20040906193620.A8502@infradead.org>
In-Reply-To: <20040906193620.A8502@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409072016.01749.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 September 2004 20:36, Christoph Hellwig wrote:
> Could you please fix UML to not use ghash.h and remove that one before
> playing with new toys?  This has been requested a few times now.
Yes, I can try - but I'd like to know the exact reason (I'm not developing UML 
as long as Jeff does).

My idea is that ghash.h is just trivial boilerplate which does not deserve 
generalized code, so that even rewriting the same exact code without using 
those macros (and maybe embedding some assumptions about this usage) would be 
a fine solution; also, there is just one user of it 
(arch/um/kernel/physmem.c, with just one hash defined), so it shouldn't be 
hard.

However, if the problem with ghash.h is different, I need more explainations.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
