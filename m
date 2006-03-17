Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWCQJP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWCQJP7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbWCQJP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:15:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45272 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751040AbWCQJP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:15:57 -0500
Message-ID: <441A7E34.90508@sgi.com>
Date: Fri, 17 Mar 2006 10:15:32 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060223)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       cotte@de.ibm.com, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>	 <20060316163728.06f49c00.akpm@osdl.org>	 <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org> <1142571490.9022.37.camel@localhost.localdomain>
In-Reply-To: <1142571490.9022.37.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>> Quite frankly, I don't think nopfn() is a good interface. It's only usable 
>> for one single thing, so trying to claim that it's a generic VM op is 
>> really not valid. If (and that's a big if) we need this interface, we 
>> should just do it inside mm/memory.c instead of playing games as if it was 
>> generic.
> 
> Or just use sparsemem and create struct pages for your hw :) we do that
> for SPUs on Cell, works like a charm.

Well then the question is, would it simplify the code using no_pfn in
this case? Hacking up fake struct page entries seems even more of a
hack to me.

Cheers,
Jes

