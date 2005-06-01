Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVFAU67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVFAU67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVFAU4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:56:38 -0400
Received: from holomorphy.com ([66.93.40.71]:20174 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261226AbVFAUy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:54:58 -0400
Date: Wed, 1 Jun 2005 13:54:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
Message-ID: <20050601205451.GR20782@holomorphy.com>
References: <200506011225.j51CPDV23243@lastovo.hermes.si> <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org> <loom.20050601T150142-941@post.gmane.org> <20050601134022.GM20782@holomorphy.com> <429E0843.5060505@tmr.com> <20050601204350.GM23621@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601204350.GM23621@csclub.uwaterloo.ca>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 03:10:59PM -0400, Bill Davidsen wrote:
>> Does this apply to mmap as well? I have an application which currently 
>> uses 9TB of data, and one thought to boost performance was to mmap the 
>> data. Unfortunately, I know 16TB isn't going to be enough for more than 
>> a few more years :-(

On Wed, Jun 01, 2005 at 04:43:50PM -0400, Lennart Sorensen wrote:
> Just buy an Opteron/Athlon64 system and you should be able to mmap it
> just fine.  At least if you run an x86_64/amd64 kernel.

Linux does not entail subscription to hardware upgrade treadmills. No
one should be forced by "peer pressure" or Linux deficiencies to buy
new hardware. And this is the single greatest thing about Linux ever.

O_LARGEFILE and current mmap() code will save him the cost of newer
hardware for the near term, and should he be particularly strapped for
cash later on when more than 16TB is needed, he knows to look at making
pgoff_t and/or swp_entry_t 64-bit on his own. There is no need for new
hardware, merely a choice between money and programming effort should
he break the 16TB barrier.


-- wli
