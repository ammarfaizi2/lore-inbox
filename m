Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbSKXEah>; Sat, 23 Nov 2002 23:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbSKXEah>; Sat, 23 Nov 2002 23:30:37 -0500
Received: from are.twiddle.net ([64.81.246.98]:48525 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267158AbSKXEag>;
	Sat, 23 Nov 2002 23:30:36 -0500
Date: Sat, 23 Nov 2002 20:36:47 -0800
From: Richard Henderson <rth@twiddle.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules as shared objects
Message-ID: <20021123203647.A1092@twiddle.net>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
References: <200211240116.RAA19023@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211240116.RAA19023@adam.yggdrasil.com>; from adam@yggdrasil.com on Sat, Nov 23, 2002 at 05:16:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2002 at 05:16:32PM -0800, Adam J. Richter wrote:
> I was wondering if there is any other ultimate benefit to your change.

I think the main benefit is leaving some of the hard bits
wrt linking to the user-space linker.  Doesn't affect x86,
but it does affect at least alpha and ia64.

> So, if you adopt a policy that the .init section will be loaded
> contiguously ...

Well, due to the way shared libraries are constructed, the
.init sections *must* be loaded contiguously no matter what.
The question is, how to free that memory.

> I should also check and see if kmalloc returns pointers in the 4MB
> kernel huge page on x86, which would improve TLB usage.

I believe it does.  This decision must be left to the per-arch
allocation routine though.


r~
