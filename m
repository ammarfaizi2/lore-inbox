Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUHANKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUHANKN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 09:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUHANKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 09:10:13 -0400
Received: from holomorphy.com ([207.189.100.168]:9382 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265928AbUHANKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 09:10:09 -0400
Date: Sun, 1 Aug 2004 06:10:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-ID: <20040801131004.GT2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, zwane@linuxpower.ca,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Matthew Dobson <colpatch@us.ibm.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com> <20040731232126.1901760b.pj@sgi.com> <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com> <20040801124053.GS2334@holomorphy.com> <20040801060529.4bc51b98.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801060529.4bc51b98.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 06:05:29AM -0700, Paul Jackson wrote:
> Either way - we need consistency.  Either find_next_bit(.., size, ...)
> returns exactly size if no more bits, or all its callers tolerate any
> return >= size.
> I probably prefer the former, because I expect slightly tighter kernel
> code now (see my previous post on text size), and fewer bugs in the
> future (more clients of find_next_bit will be coded than new
> implementations of it), if we go this way.  William's comments suggest
> to me he prefers the later.
> Either (or both) seems better than what we have.
> William - can you read the find_next_bit() implementations in some other
> arch's well enough to understand if they are anal about returning
> exactly 'size', or content to return something >= size, when they run
> out of bits?  That code was a bit denser than I could deal with easily.
> If a strong majority of the arch's find_next_bit() are anal, or on the
> other hand, are not, then I'd suggest we follow their lead.

A strong majority return BITS_PER_LONG-aligned results in this case.


-- wli
