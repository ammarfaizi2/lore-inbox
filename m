Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbUDGBkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 21:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUDGBkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 21:40:09 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:22103 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263273AbUDGBkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 21:40:05 -0400
Date: Wed, 7 Apr 2004 11:39:17 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org, hugh@veritas.com,
       vrajesh@umich.edu, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040407113917.E3391@wobbly.melbourne.sgi.com>
References: <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random> <20040403155958.GF2307@dualathlon.random> <20040403170258.GH2307@dualathlon.random> <20040405105912.A3896@infradead.org> <20040405131113.A5094@infradead.org> <20040406042222.GP2234@dualathlon.random> <20040405214330.05e4ecd7.akpm@osdl.org> <20040406215441.GK2234@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040406215441.GK2234@dualathlon.random>; from andrea@suse.de on Tue, Apr 06, 2004 at 11:54:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 11:54:41PM +0200, Andrea Arcangeli wrote:
> 
> Christoph, I got no positive feedback yet for the alternate fix you
> proposed and it's not obvious to my eyes (isn't good_pages going to be
> screwed with your fix?), but I wanted to checkin a fix into CVS in the
> meanwhile, so for now I've checked in my __GFP_NO_COMP fix that I'm sure
> doesn't require any testing since it's obviously safe and it should
> definitely fix the problem. This way you can also take your time for the
> testing of your better fix.
> 
> What's not clear to me about your fix is if it's really working safe
> with good_pages being overdecremented (good_pages doesn't look just an
> hint, there seems to be a valid reason you're doing the set_bit/test_bit
> on page->private, no?).

Ignore the first part of that patch, it was misdirected (Christoph
woulda gone through and put guards around all pagebuf page->private
users; turns out the first change was unnecessary, and confusing ;).

cheers.

-- 
Nathan
