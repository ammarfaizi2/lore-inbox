Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbUL1Oao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbUL1Oao (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 09:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUL1Oao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 09:30:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48300 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261243AbUL1Oad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 09:30:33 -0500
Date: Tue, 28 Dec 2004 09:53:48 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@osdl.org>, arjan@infradead.org, paulus@samba.org,
       clameter@sgi.com, akpm@osdl.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
Message-ID: <20041228115348.GB25253@logos.cnet>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com> <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com> <16843.13418.630413.64809@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0412231325420.2654@ppc970.osdl.org> <1103879668.4131.15.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0412241018430.2654@ppc970.osdl.org> <20041227145057.4c5cd651.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227145057.4c5cd651.davem@davemloft.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 02:50:57PM -0800, David S. Miller wrote:
> On Fri, 24 Dec 2004 10:21:24 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Absolutely. I would want to see some real benchmarks before we do this.  
> > Not just some microbenchmark of "how many page faults can we take without
> > _using_ the page at all".
> 
> Here's my small contribution.  I did three "make -j3 vmlinux" timed
> runs, one running a kernel without the pre-zeroing stuff applied,
> one with it applied.  It did shave a few seconds off the build
> consistently.  Here is the before:
> 
> real	8m35.248s
> user	15m54.132s
> sys	1m1.098s
> 
> real	8m32.202s
> user	15m54.329s
> sys	1m0.229s
> 
> real	8m31.932s
> user	15m54.160s
> sys	1m0.245s
> 
> and here is the after:
> 
> real	8m29.375s
> user	15m43.296s
> sys	0m59.549s
> 
> real	8m28.213s
> user	15m39.819s
> sys	0m58.790s
> 
> real	8m26.140s
> user	15m44.145s
> sys	0m58.872s

Christopher and other SGI fellows,

Get your patch into STP, once its there we can do some wider x86 benchmarking 
easily.

