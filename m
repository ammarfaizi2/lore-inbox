Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751328AbWFEThp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWFEThp (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 15:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWFEThp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 15:37:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:48785 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751328AbWFETho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 15:37:44 -0400
Date: Mon, 5 Jun 2006 12:37:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@google.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andy Whitcroft <apw@shadowen.org>,
        "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, ak@suse.de,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <448486FB.8060007@google.com>
Message-ID: <Pine.LNX.4.64.0606051234440.18361@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com>  <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org>  <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org>  <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org>  <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <1149533399.3111.120.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0606051151150.18056@schroedinger.engr.sgi.com>
 <44848283.3000207@google.com> <Pine.LNX.4.64.0606051216290.18264@schroedinger.engr.sgi.com>
 <448486FB.8060007@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006, Martin Bligh wrote:

> No, that is the config it starts with, sorry ... that was misleading.
> It then does makeoldconfig from there:
> 
> http://test.kernel.org/abat/34624/build/dotconfig

Ok. So page migration is enabled.

> > Either what we see is due to code rearrangement or there is something wrong
> > with the fallback definitions in include/linux/swapops.h. 
> > The swapless-pm-add-r-w-migration-entries.patch also introduces Hugh's
> > reversal of the anon_vma list.
> 
> OK, are those easily separable? Sounds like one good test would be to
> force CONFIG_MIGRATION to =n, right?

CONFIG_MIGRATION off will disable the page migration stuff and make swap 
types 30 / 31 usable as before. The reversal of the order for the anon_vma 
list will be preserved.

So yes it may lead us further. If the problem persists with 
CONFIG_MIGRATION=n then the anon_vma reversal may be an issue.

