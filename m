Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVBZMj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVBZMj5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 07:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVBZMj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 07:39:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48333 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261180AbVBZMjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 07:39:55 -0500
Date: Sat, 26 Feb 2005 13:39:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Mark Haverkamp <markh@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH] Fix panic in 2.6 with bounced bio and dm
Message-ID: <20050226123934.GA1254@suse.de>
References: <1109351021.5014.10.camel@markh1.pdx.osdl.net> <20050225161947.5fd6d343.akpm@osdl.org> <Pine.LNX.4.58.0502251640050.9237@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502251640050.9237@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25 2005, Linus Torvalds wrote:
> 
> 
> On Fri, 25 Feb 2005, Andrew Morton wrote:
> > 
> > It seems very weird for dm to be shoving NULL page*'s into the middle of a
> > bio's bvec array, so your fix might end up being a workaround pending a
> > closer look at what's going on in there.
> 
> Yes. I don't see how this patch can be anything but bandaid to hide the 
> real bug. Where do these "non-page" bvec's originate?

Yep that's the fishy part, there should not be NULL pages in the middle
(or empty bios, for that matter) submitted for io.

Mark, what was the bug that triggered you to write this patch?

-- 
Jens Axboe

