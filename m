Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265388AbVBDRC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265388AbVBDRC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbVBDRC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:02:56 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:37836 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265273AbVBDRCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:02:50 -0500
Date: Fri, 4 Feb 2005 09:02:10 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Paul Mackerras <paulus@samba.org>
cc: Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: A scrub daemon (prezeroing)
In-Reply-To: <16899.15980.791820.132469@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0502040900450.759@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
 <20050202163110.GB23132@logos.cnet> <Pine.LNX.4.61.0502022204140.2678@chimarrao.boston.redhat.com>
 <16898.46622.108835.631425@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0502031650590.26551@schroedinger.engr.sgi.com>
 <16899.2175.599702.827882@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0502032220430.28851@schroedinger.engr.sgi.com>
 <16899.15980.791820.132469@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Paul Mackerras wrote:

> > Yes but its a short burst that only occurs very infrequestly and it takes
>
> It occurs just as often as we clear pages in the page fault handler.
> We aren't clearing any fewer pages by prezeroing, we are just clearing
> them a bit earlier.

scrubd clears pages of orders 7-4 by default. That means 2^4 to 2^7
pages are cleared at once.
