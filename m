Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUFAPO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUFAPO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUFAPOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:14:21 -0400
Received: from holomorphy.com ([207.189.100.168]:63120 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262730AbUFAPNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:13:12 -0400
Date: Tue, 1 Jun 2004 08:09:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
Message-ID: <20040601150913.GU2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se> <c892nk$5pf$1@terminus.zytor.com> <16572.38987.239160.819836@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16572.38987.239160.819836@alkaid.it.uu.se>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 04:52:59PM +0200, Mikael Pettersson wrote:
> You're assuming pointers have uniform representation.
> C makes no such guarantees, and machines _have_ had
> different types of representations in the past.
> Some not-so-obsolete 64-bit machines in effect use fat
> representations for pointers to functions (descriptors),
> but they usually cheat and use pointers to the descriptors
> instead. However, a C implementation could legally
> represent a function pointer as a 128-bit value, while
> data pointers remain 64 bits.

IIRC for all types foo, sizeof(foo *) <= sizeof(void *), no?
If so, 128-bit function pointers implies >= 128-bit void pointers.


On Tue, Jun 01, 2004 at 04:52:59PM +0200, Mikael Pettersson wrote:
> A cast fundamentally involves an assignment conversion,
> a copy to a temporary, and it yields an rvalue.
> Even if we allow its use as an lvalue, the semantics
> would still be to assign the copy not the original.
> So cast-as-lvalue as gcc implemented it changed two
> major aspects of the semantics. Call me conservative
> if you like, but that's simply not C any more.

Oh, yeah, lvalue casting is degenerate filth.


-- wli
