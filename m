Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWHIHoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWHIHoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 03:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbWHIHoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 03:44:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10679 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964927AbWHIHoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 03:44:13 -0400
Date: Wed, 9 Aug 2006 09:43:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       Sahil Rihan <srihan@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060809074352.GL4886@elf.ucw.cz>
References: <44D1CC7D.4010600@vmware.com> <44D217A7.9020608@redhat.com> <44D24236.305@vmware.com> <20060805104507.GA4506@ucw.cz> <44D67109.6020605@vmware.com> <20060808001255.GQ2759@elf.ucw.cz> <44D7DDEF.6070907@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D7DDEF.6070907@vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Well, I guess we'd like VMI to be buildable in normal kernel build
> >tools ... and at that point, open sourcing it should be _really_ easy.
> >
> >And we'd prefer legal decisions not to influence technical ones. Maybe
> >we will decide to use binary interface after all, but seeing GPLed,
> >easily-buildable interface, first, means we can look at both solutions
> >and decide which one is better.
> 
> I don't think you're actually arguing for the VMI ROM to be built into 
> the kernel.  But since this could be a valid interpretation of what you 
> said, let me address that point so other readers of this thread don't 
> misinterpret.

I actually was arguing for VMI ROM to be built into kernel. You have
pretty strong arguments why it will not work, but Xen is doing that,
and it would be at least very interesting to see how it works for
vmware. (And perhaps to decide that it does not work :-).

> On a purely technical level, the VMI layer must not be part of the 
> normal kernel build.  It must be distributed by the hypervisor to
> which 

Oh yes, it can be part of kernel build. #ifdef vmware_version_3_0_4 is
ugly, but at least it would force you not to change the interfaces too
often, which might be good thing.

> We do use standard tools for building it, for the most part - although 
> some perl scripting and elf munging magic is part of the build.  
> Finally, since it is a ROM, we have to use a post-build tool to convert 
> the extracted object to a ROM image and fix up the checksum.  We don't 
> have a problem including any of those tools in an open source 
> distribution of the VMI ESX ROM once we finish sorting through the 
> license issues.  We've already fixed most of the problems we had with 
> entangled header files so that we can create a buildable tarball that 
> requires only standard GNU compilers, elf tools, and perl to run.  I 
> believe the only technical issue left is fixing the makefiles so that 
> building it doesn't require our rather complicated make system.

Good, nice, so you are close. Now get us GPLed release ;-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
