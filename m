Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264715AbUEJOqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264715AbUEJOqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbUEJOqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:46:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54734 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264715AbUEJOpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:45:04 -0400
Date: Mon, 10 May 2004 16:44:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
Message-ID: <20040510144454.GH14403@suse.de>
References: <20040507093921.GD21109@suse.de> <200405072200.i47M0AF00868@unix-os.sc.intel.com> <20040510143024.GF14403@suse.de> <409F9510.9050001@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409F9510.9050001@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11 2004, Nick Piggin wrote:
> Jens Axboe wrote:
> >On Fri, May 07 2004, Chen, Kenneth W wrote:
> >
> >>>>>>Jens Axboe wrote on Friday, May 07, 2004 2:39 AM
> >>>
> >>>On Thu, May 06 2004, Chen, Kenneth W wrote:
> >>>
> >>>>(3) can we allocate request structure up front in __make_request?
> >>>>   For I/O that cannot be merged, the elevator code executes twice
> >>>>   in __make_request.
> >>>>
> >>>
> >>>Actually, with the good working batching we might get away with killing
> >>>freereq completely. Have you tested that (if not, could you?)
> >>
> >>Sorry, I'm clueless on "good working batching".  If you could please give
> >>me some pointers, I will definitely test it.
> >
> >
> >Something like this.
> >
> 
> While we're doing that can we drop the GFP_ATOMIC allocation
> completely?

Thought the same thing. But lets stick to single item tests first, then
we can kill that double allocation after.

-- 
Jens Axboe

