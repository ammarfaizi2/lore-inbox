Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbUJ1Ab5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbUJ1Ab5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUJ1A3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:29:18 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:25984 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262670AbUJ1A2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:28:11 -0400
Date: Thu, 28 Oct 2004 01:27:57 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual Opteron box, what's the optimal memory placement for the CPUs?
Message-ID: <20041027232757.GB9093@vana.vc.cvut.cz>
References: <Pine.LNX.4.61.0410272316160.3284@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0410271439000.6240@twin.uoregon.edu> <Pine.LNX.4.61.0410272355300.3284@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410272355300.3284@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 12:00:45AM +0200, Jesper Juhl wrote:

> Yeah, I know they have to be installed in pairs, but I would have thought 
> that it would be best to have an even memory distribution so that an even 
> amount of local memory was available to processes executing on either CPU. 
> Even if Linux makes sure to execute processes on the CPU where most of 
> their memory is local, wouldn't a non-even distribution make more 
> processes prefer one CPU and thus not make the best possible use of them?
> 
> I don't really know very much about this specific detail (which is why I 
> asked), and you tell me it doesn't matter, so I'll assume Linux has some 
> intelligent way of dealing with this that I just don't know about - That's 
> good enough for me, I'll trust you on that, just wanted to know for now 
> and the future. :-)

You should also check this with your BIOS.  It will be a bit unfortunate 
if BIOS decides to just throw away 0.5GB of your memory to make space
for PCI devices, and maybe you can help BIOS a bit with right
shuffling (with 3:1 it will hopefully decide to put 1GB above
4GB boundary; with 2:2 who knows; AFAIK Opteron northbridge does not
allow for splitting DRAM on one node into two regions; at least I did not 
found how to do that).

I would prefer 2:2 if both variants give you same amount of accessible
memory.
						Best regards,
							Petr Vandrovec
