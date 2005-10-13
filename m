Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVJNJ2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVJNJ2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 05:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJNJ2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 05:28:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22178 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751173AbVJNJ2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 05:28:52 -0400
Date: Thu, 13 Oct 2005 13:17:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Jeff Mahoney <jeffm@suse.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051013111707.GB516@openzaurus.ucw.cz>
References: <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz> <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com> <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com> <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>- the write of these data waits until the dialog window is 
> >>displayed,
> >>user inserts the device and clicks 'OK'
> >
> >No, it's not, and deadlock is definitely possible. However, if we're 
> >at
> >the point where memory is tight enough that it's an issue, the timer 
> >can
> >expire and all the pending i/o is dropped just as it would be without
> >the multipath code enabled.
> >
> >I'm not saying it's a solution ready for production, just a good
> >starting point.
> 
> But discarding data sometimes on USB unplug is even worse than 
> discarding data always --- users will by experimenting learn that 

*Good starting point*.

Anyway, one solution would be to simply mlockall() on that
replugitd and/or make dirty data hdd based
(not ram based) and/or
restricting dirty buffers to 10MB for removable media.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

