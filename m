Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTLDV2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 16:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTLDV2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 16:28:09 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:1730 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263580AbTLDV2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 16:28:07 -0500
Date: Fri, 5 Dec 2003 08:26:41 +1100
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: pinotj@club-internet.fr, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031204212641.GC567@frodo>
References: <mnet1.1070562461.26292.pinotj@club-internet.fr> <Pine.LNX.4.58.0312041035530.6638@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312041035530.6638@home.osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 10:49:07AM -0800, Linus Torvalds wrote:
> 
> Nathan - did you see the two debug patches I sent out that caught this?
> 
> One adds checks to "atomic_dec_and_test()" to verify that the count never
> goes negative. The other basically disables all the slab code, and
> replaces them with straight page allocations, and that together with
> CONFIG_DEBUG_PAGEALLOC helps find bad behaviour (touching allocations
> after they are free'd etc).
> 

Yep - I'll remove that PageSlab use in there, and start testing
with these too.

thanks.

-- 
Nathan
