Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVAXVYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVAXVYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVAXVWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:22:09 -0500
Received: from waste.org ([216.27.176.166]:22709 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261595AbVAXVVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:21:08 -0500
Date: Mon, 24 Jan 2005 13:20:37 -0800
From: Matt Mackall <mpm@selenic.com>
To: Felipe Alfaro Solana <lkml@mac.com>
Cc: Andi Kleen <ak@muc.de>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050124212037.GJ3867@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net> <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de> <5ADB1D78-6CFB-11D9-86B4-000D9352858E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ADB1D78-6CFB-11D9-86B4-000D9352858E@mac.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 05:58:00AM +0100, Felipe Alfaro Solana wrote:
> On 23 Jan 2005, at 03:39, Andi Kleen wrote:
> 
> >Felipe Alfaro Solana <lkml@mac.com> writes:
> >>
> >>AFAIK, XOR is quite expensive on IA32 when compared to simple MOV
> >>operatings. Also, since the original patch uses 3 MOVs to perform the
> >>swapping, and your version uses 3 XOR operations, I don't see any
> >>gains.
> >
> >Both are one cycle latency for register<->register on all x86 cores
> >I've looked at. What makes you think differently?
> 
> I thought XOR was more expensie. Anyways, I still don't see any 
> advantage in replacing 3 MOVs with 3 XORs.

Again, no temporaries needed.

But I benched it and it was quite a bit slower.

-- 
Mathematics is the supreme nostalgia of our time.
