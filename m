Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVIFVtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVIFVtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVIFVtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:49:12 -0400
Received: from ns.suse.de ([195.135.220.2]:25238 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750979AbVIFVtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:49:11 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, Terrence.Miller@sun.com
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" -> "static inline"
Date: Tue, 6 Sep 2005 23:49:00 +0200
User-Agent: KMail/1.8
Cc: Jakub Jelinek <jakub@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Michael Matz <matz@suse.de>, linux-kernel@vger.kernel.org
References: <20050902203123.GT3657@stusta.de> <200509062223.50747.ak@suse.de> <431E023E.3050301@Sun.COM>
In-Reply-To: <431E023E.3050301@Sun.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509062349.01517.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 22:55, Terrence Miller wrote:
> Andi Kleen wrote:
> > I don't think the functionality of having single copies in case
> > an out of line version was needed was ever required by the Linux kernel.
>
> But shouldn't the compiler that compiles Linux be C99 compliant?

At least the kernel and some core functionality (glibc) has been
traditionally written in GNU C, not ISO C. So no, that is not
a design goal.

Of course on the other hand GNU C is getting more and more like 
ISO C with the gcc people dropping extensions over time.

Some of the extension use is probably more by mistake, but 
others (like typeof, inline assembly, statement expressions) are widely
and intentionally used and would be quite hard to replace.

However people have built the kernel with non gcc compilers,
it just needed extensive modifications to either the compiler
or the kernel.

-Andi
