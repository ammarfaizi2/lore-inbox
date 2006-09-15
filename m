Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWIOJE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWIOJE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 05:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWIOJE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 05:04:28 -0400
Received: from mx2.go2.pl ([193.17.41.42]:37603 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1750794AbWIOJE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 05:04:27 -0400
Date: Fri, 15 Sep 2006 11:08:19 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-ID: <20060915090819.GB2572@ff.dom.local>
References: <20060913065010.GA2110@ff.dom.local> <20060914181754.bd963f6d.akpm@osdl.org> <20060915081123.GA2572@ff.dom.local> <20060915012302.d459c2dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915012302.d459c2dc.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 01:23:02AM -0700, Andrew Morton wrote:
> On Fri, 15 Sep 2006 10:11:23 +0200
> Jarek Poplawski <jarkao2@o2.pl> wrote:
> > As a matter of fact today I think my patch is wrong.
... 
> No, I think it's OK.  Well, you had an off-by-one...

just like the source:

 > +#if 0xFF >= MAX_MP_BUSSES
 >  	if (m->mpc_busid >= MAX_MP_BUSSES) {

...
> > but after rethinking
> > the question of Dave Jones I see it's fixing the result
> > instead of the source of a problem (char or not char).
> 
> The mpc_busid field is set to eight-bits by BIOS; there's nothing we can do
> about that...
 
So IMHO maybe: if we can know this only by BIOS it should be
eight-bits - if there is another way to get this: shouln't
you add second constant? Now it's unlogical for me (and it
induces this strange #ifs in the code instead of headers).

Jarek P.  
