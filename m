Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVKIX66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKIX66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVKIX66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:58:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750802AbVKIX66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:58:58 -0500
Date: Wed, 9 Nov 2005 15:58:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, len.brown@intel.com, jgarzik@pobox.com,
       tony.luck@intel.com, bcollins@debian.org, scjody@modernduck.com,
       dwmw2@infradead.org, rolandd@cisco.com, davej@codemonkey.org.uk,
       axboe@suse.de, shaggy@austin.ibm.com, sfrench@us.ibm.com
Subject: Re: merge status
In-Reply-To: <20051109150141.0bcbf9e3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0511091547160.4627@g5.osdl.org>
References: <20051109133558.513facef.akpm@osdl.org> <1131573041.8541.4.camel@mulgrave>
 <Pine.LNX.4.64.0511091358560.4627@g5.osdl.org> <1131575124.8541.9.camel@mulgrave>
 <20051109150141.0bcbf9e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, Andrew Morton wrote:
> 
> One could just say "if I don't have it by the time 2.6.n is released, it
> goes into 2.6.n+2", but that's probably getting outside the realm of
> practicality.

I think it would be a good thing to _aim_ for, and just to keep things 
practical just not make it too much of a hard rule.

I think one reason -mm has worked so damn well (apart from you being "The 
Calmest Man on Earth"(tm)) is because it's essentially been that buffer 
for anything non-trivial. Sometimes the "n+2" has been a lot more than 
"n+2" in fact, and that's often good.

(And at the same time, -mm has enough visibility that it doesn't drive 
developers crazy even when the "n+2" ends up being "n+5" or somethiing).

I'd _hope_ that the same kind of situation could work for some of the 
majos subsystem git trees too: where the maintainer tree is well enough 
known that it gets sufficient coverage for that area that a "+2" approach 
for merging into the default kernel is practical.

I also think it certainly _should_ be possible for the big areas that have
well-defined target audiences. Especially since git should hopefulyl be 
very good at allowing such a target audience to actually track (and merge) 
such trees on their own.

Ie it should be perfectly possible (and easy) to track both my tree and 
some other tree (sound, scsi, network device development) in two branches, 
and the person doing that tracking should have basically trivial merging.

So we do have the technology. Whether we can make it work in practice, 
that's another issue ;)

			Linus
