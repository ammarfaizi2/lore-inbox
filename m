Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268021AbUHEXzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268021AbUHEXzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268022AbUHEXzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:55:07 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:10895 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268021AbUHEXzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:55:00 -0400
Date: Fri, 6 Aug 2004 00:54:26 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Ian Romanick <idr@us.ibm.com>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: DRM function pointer work..
In-Reply-To: <4112C09B.1070603@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0408060043300.9947@skynet>
References: <Pine.LNX.4.58.0408031427540.31513@skynet>
 <Pine.LNX.4.58.0408041201490.30393@skynet> <41128B90.5070702@us.ibm.com>
 <Pine.LNX.4.58.0408052338010.9947@skynet> <4112C09B.1070603@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[lk ppl have a look at the start of this thread in the dri-devel archives
on marc.theaimsgroup.com...]

> I guess one (unpleasant) way to make it work would be to add the version to
> all the symbols in the device-independent layer.  Instead of drm_foo you'd
> have drm_foo_100 or drm_foo_101 or whatever.  You could then have multiple
> modules loaded or a module loaded with a built-in version.  I'm not sure how
> happy that would make the kernel maintainers (not to mention how happy it
> would make us). :(  It's basically like what we have now, except the current
> code has the device's name add to all the symbols and is built into the
> device-dependent module.  Ugh, ugh.
>
> How do other multi-layer kernel modules handle this?  For example, how does
> agpgart or iptables do it?

they don't let crazy people build stuff outside the tree as far as I know
... also they make you build against the current kernel headers, so we
would have to have the drm headers in include/linux/drm or somewhere like
that, and build the modules against them, but then what happens if you
want to build a new drm module out of tree..

two things make my head hurt, 32/64 interfaces and versioning.., maybe
some more experienced kernel heads could join this and tell us the best
way to go?

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

