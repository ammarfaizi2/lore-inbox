Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVCZFyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVCZFyn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 00:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVCZFyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 00:54:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34775 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262013AbVCZFyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 00:54:41 -0500
Date: Fri, 25 Mar 2005 21:52:55 -0800
From: Jason Uhlenkott <jasonuhl@sgi.com>
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm3
Message-ID: <20050326055255.GA210003@dragonfly.engr.sgi.com>
References: <20050325002154.335c6b0b.akpm@osdl.org> <20050326014327.GB207782@dragonfly.engr.sgi.com> <1111802218.19916.59.camel@d845pe> <20050326020212.GC207782@dragonfly.engr.sgi.com> <1111803861.19920.91.camel@d845pe> <20050326025704.GE207782@dragonfly.engr.sgi.com> <1111810359.19919.113.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111810359.19919.113.camel@d845pe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 11:12:39PM -0500, Len Brown wrote:
> I realize now I didn't answer your original question.
> The reason ACPI now depends on PM is that
> it makes it easier for us to do a more orderly shutdown --
> acpi registers as a device so it can do some stuff
> upon the PM device shutdowns -- before interrupts are disabled.
> 
> I think with all the twisty turney passages
> related to the suspend states, poweroff, sys-req, and now kexec,
> that it is best if we can keep the code paths as
> common as possible or some of them will never get the
> testing needed to prevent them from getting broken.
> 
> Also, it is now common practice to include PM && ACPI together
> in the x86 world.  Though technically one could have
> ACPI w/o PM and you'd have lost only ACPI_SLEEP, virtually
> nobody seems to use/depend-on that combination.

OK, that makes sense.  I see now that Jesse has already sent a patch
to allow CONFIG_PM on sn2, so we'll be fine as soon as that gets
merged.
