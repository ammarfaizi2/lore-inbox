Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWJFRT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWJFRT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422770AbWJFRTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:19:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:40659 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422765AbWJFRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:19:54 -0400
Date: Fri, 6 Oct 2006 10:17:37 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4]
In-Reply-To: <20061006141704.GH2563@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0610061015570.14591@schroedinger.engr.sgi.com>
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
 <20061006141704.GH2563@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006, Matthew Wilcox wrote:

> On Fri, Oct 06, 2006 at 02:34:14PM +0100, David Howells wrote:
> > +config ARCH_HAS_ILOG2_U32
> > +	bool
> > +	default n
> 
> Why not "def_bool n"?  Or indeed, since the default is n, why not just
> "bool"?

Why so complicated and why do it at all? We already have fls and ffs 
amoung the bit operations and those map to cpu instructions on arches 
that support these. fls can be used as a log 2 facilities. If you need 
another name and further refine it then just add an inline function.

