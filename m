Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVBXWw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVBXWw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVBXWw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:52:28 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:3925 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262538AbVBXWwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:52:25 -0500
Message-ID: <421E5AA5.3040100@yahoo.com.au>
Date: Fri, 25 Feb 2005 09:52:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>     <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>     <20050217230342.GA3115@wotan.suse.de>     <20050217153031.011f873f.davem@davemloft.net>     <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au>     <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>     <421B0163.3050802@yahoo.com.au>     <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>     <421D1737.1050501@yahoo.com.au>     <Pine.LNX.4.61.0502240457350.5427@goblin.wat.veritas.com>     <1109224777.5177.33.camel@npiggin-nld.site>     <Pine.LNX.4.61.0502241143001.6630@goblin.wat.veritas.com>     <421E4E27.20004@yahoo.com.au> <Pine.LNX.4.61.0502242224070.14886@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0502242224070.14886@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> At one stage I was adding unlikelies to all the p??_bads, then it
> seemed more sensible to hide that in a new macro (which of course
> must do the none and bad tests inline, before going off to the function).
> 

Yeah that sounds OK. I think (un)likely can propagate through
inline functions too, if that's any help to you.

> 
> We could at little cost.  But I think if these messages come up at all,
> they're likely to come up in clumps, where the backtrace won't actually
> be giving any interesting info, and the quantity of them be a nuisance
> itself.  I'd rather leave it to the next person who gets the error and
> wants the backtrace to add it.
> 

You're probably right - I know when I see them (from my
hacking up the code) they usually come in clumps :P

Nick

