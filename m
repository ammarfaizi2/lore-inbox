Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269080AbUIXTJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269080AbUIXTJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 15:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269096AbUIXTJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 15:09:39 -0400
Received: from waste.org ([209.173.204.2]:21203 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269080AbUIXTJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 15:09:37 -0400
Date: Fri, 24 Sep 2004 14:09:03 -0500
From: Matt Mackall <mpm@selenic.com>
To: James Morris <jmorris@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jean-Luc Cooke <jlcooke@certainkey.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040924190903.GY31237@waste.org>
References: <20040924174301.GB20320@thunk.org> <Xine.LNX.4.44.0409241440410.8732-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0409241440410.8732-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 02:43:07PM -0400, James Morris wrote:
> On Fri, 24 Sep 2004, Theodore Ts'o wrote:
> 
> > have *any* encryption algorithms in the kernel at all.  As to whether
> > or not cryptoapi needs to be mandatory in the kernel, the question is
> > aside from /dev/random, do most people need to have crypto in the
> > kernel?  If they're not using ipsec, or crypto loop devices, etc.,
> > they might not want to have the crypto api in their kernel
> > unconditionally.
> 
> As far as I know embedded folk do not want the crypto API to be mandatory,
> although I think Matt Mackall wanted to try and make something work
> (perhaps a subset just for /dev/random use).

I want to move a couple critical hash algorithms into lib/ as has been done
with the CRC code. Then cryptoapi and /dev/random and a couple other
things (htree comes to mind) could share code without inflicting the
cryptoapi overhead and context limitations on everyone.

(currently about 4k messages behind on lkml, sorry for not chiming in sooner)

-- 
Mathematics is the supreme nostalgia of our time.
