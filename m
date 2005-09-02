Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVIBUle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVIBUle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVIBUle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:41:34 -0400
Received: from ns1.suse.de ([195.135.220.2]:20667 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751330AbVIBUld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:41:33 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>
	<4317F136.4040601@yahoo.com.au>
	<1125666486.30867.11.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 02 Sep 2005 22:41:31 +0200
In-Reply-To: <1125666486.30867.11.camel@localhost.localdomain>
Message-ID: <p73k6hzqk1w.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Gwe, 2005-09-02 at 16:29 +1000, Nick Piggin wrote:
> > 2/7
> > Implement atomic_cmpxchg for i386 and ppc64. Is there any
> > architecture that won't be able to implement such an operation?
> 
> i386, sun4c, ....

Actually we have cmpxchg on i386 these days - we don't support
any SMP i386s so it's just done non atomically.
 
> Yeah quite a few. I suspect most MIPS also would have a problem in this
> area.

cmpxchg can be done with LL/SC can't it? Any MIPS should have that.

-Andi
