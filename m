Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbTLKTsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbTLKTsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:48:35 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:45831 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265225AbTLKTsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:48:23 -0500
Date: Thu, 11 Dec 2003 19:48:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@hpl.hp.com>, jbarnes@sgi.com,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] quite down SMP boot messages
Message-ID: <20031211194818.A25999@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@wildopensource.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	David Mosberger <davidm@hpl.hp.com>, jbarnes@sgi.com,
	Rusty Russell <rusty@rustcorp.com.au>
References: <yq0fzfr32ib.fsf@wildopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <yq0fzfr32ib.fsf@wildopensource.com>; from jes@wildopensource.com on Thu, Dec 11, 2003 at 08:30:52AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 08:30:52AM -0500, Jes Sorensen wrote:
> Hi,
> 
> I'd like to propose this patch for 2.6.0 or 2.6.1 to quite down some
> of the excessive boot messages printed for each CPU. The patch simply
> introduces a boot time variable 'smpverbose' which users can set if
> they experience problems and want to see the full set of messages.
> 
> Once you hit > 2 CPUs the amount of noise printed per CPU starts
> becoming a pain, at 64 CPUs it's turning into a royal pain ....
> 
> Oh and I also killed a NULL initializer in kernel/cpu.c - bad Rusty ;-)

Just kill the silly option, these messages are completly useless.
And IIRC we didn't have them in 2.4 either..

