Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUHPK3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUHPK3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267514AbUHPK3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:29:51 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:61628 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267507AbUHPK3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:29:49 -0400
Date: Mon, 16 Aug 2004 11:29:48 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <20040816105014.A9367@infradead.org>
Message-ID: <Pine.LNX.4.58.0408161101050.21177@skynet>
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org>
 <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org>
 <Pine.LNX.4.58.0408161019040.21177@skynet> <20040816105014.A9367@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> no, now you're acting like an even more broken driver, preventing a fbdev
> driver to be loaded afterwards and doing all kinds of funny things.  Please
> revert to the old method until you have a common pci_driver for fbdev and dri.
>

the options we have are
1) move the DRM to be a real PCI driver now - stop fb from working on same
card

2) move the DRM to act like a real PCI driver when fb isn't loaded, when
we merge we rip the code out..

the other option is not going to happen unless Linus/Andrew/Alan tell us
to go away do it that away and will then unconditionally merge a
mega-patch when I'm finished - you can't have it both ways we fix things
step-by-step or we leave it as is and nobody fixes it, so Christoph I
repsect your opinion but unless you care about this enough to do the work
on it, the way we are going seems to be the best way to avoid breaking
things and I'm leaving the decision on whether to merge this stuff or not
to Linus/Andrew - btw in case anyone wants to look the patch is whats at:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc4/2.6.8-rc4-mm1/broken-out/bk-drm.patch

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

