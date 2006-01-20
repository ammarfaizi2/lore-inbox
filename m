Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWATJLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWATJLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 04:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWATJLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 04:11:44 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:23962 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750763AbWATJLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 04:11:43 -0500
Date: Fri, 20 Jan 2006 01:10:56 -0800
From: Paul Jackson <pj@sgi.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: lethal@linux-sh.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       spyro@f2s.com, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com, david-b@pacbell.net, rmk@arm.linux.org.uk
Subject: Re: [PATCH] bitmap: Support for pages > BITS_PER_LONG.
Message-Id: <20060120011056.be8f23b2.pj@sgi.com>
In-Reply-To: <1137727710.3571.51.camel@mulgrave>
References: <20060119014812.GB18181@linux-sh.org>
	<20060118191157.f653b09d.pj@sgi.com>
	<1137727710.3571.51.camel@mulgrave>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James wrote:
> Is wrong.  You're looking for an unset span of order bits at a given
> offset. 

But your comment, James, said:

 * This is used to allocate a memory region from a bitmap.  The idea is
 * that the region has to be 1<<order sized and 1<<order aligned (this
 * makes the search algorithm much faster).



So, like the other Paul said:
> Unless I'm missing something, I don't see how your case
> would happen.

James further wrote:
>   i.e. (assuming BITS_PER_LONG=32) for a span
> of 126 at offset 1, you check

I thought that the span had to be a power of two.  Perhaps
you mean 128, not 126 (order 7: 2**7 == 128).

And I thought, from your comment above, that if the span was
128, then the alignment had to be 128 as well.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
