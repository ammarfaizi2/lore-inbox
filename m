Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263450AbUJ3Cml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263450AbUJ3Cml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 22:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUJ3Cml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 22:42:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:34451 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263459AbUJ3Clj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 22:41:39 -0400
Subject: Re: [PATCH] document mmiowb and readX_relaxed a bit more in
	deviceiobook.tmpl
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200410291747.24035.jbarnes@engr.sgi.com>
References: <200410291747.24035.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 12:35:56 +1000
Message-Id: <1099103756.29689.194.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 17:47 -0700, Jesse Barnes wrote:
> This is a small patch to deviceiobook.tmpl to describe the new mmiowb routine 
> a bit more completely.  I've also updated it to provide pointers to drivers 
> that do write flushing, use mmiowb, and use the readX_relaxed routines.

It's all good, but your semantics and description are very tailored to
your specific arch problem vs. unlock.

What about my suggestion of defining a broader semantic of mmiowb() as
beeing a barrier ordering MMIOs vs. the rest of the world ? The later
includes stores to memory _and_ spinlock/unlock.

I still intend to eventually make good use of that on ppc64 to get rid
of the expensive barriers we had to put in our writeX() implementations,
though I didn't have time to work on that yet.

Ben.


