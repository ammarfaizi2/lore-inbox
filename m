Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUHPLCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUHPLCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267528AbUHPLCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:02:19 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:23233 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267522AbUHPLCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:02:16 -0400
Date: Mon, 16 Aug 2004 12:02:15 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <20040816113848.A9683@infradead.org>
Message-ID: <Pine.LNX.4.58.0408161142490.21177@skynet>
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org>
 <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org>
 <Pine.LNX.4.58.0408161019040.21177@skynet> <20040816105014.A9367@infradead.org>
 <Pine.LNX.4.58.0408161101050.21177@skynet> <20040816113848.A9683@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> 3) stop making broken changes.

The current system is broken in way more subtle ways...

> 	You do stop fb from beeing loaded after drm
> and thus break perfectly working setups during stable series.  And you

I doubt anyone has a system that does it and they should have a broken one
if they do it.. drm has also said you should load fb before it.. and
having both fb and drm loaded on the same hardware is a hack anyways..

> introduce indeterministic behaviour, and although I haven't looked at the
> code because unlike every guideline tells you you didn't post it to do the
> list, probably horribly broken code.

I just did post it, it's been in the DRM CVS tree for 3-6 mths now, it's
been in -mm for 1.5 mths, I've followed what Andrew and Linus told me to
do to get the DRM maintained... the link I posted in the last mail to the
broken out patch in the -mm tree, the only file to change is really
drm_drv.h and some bits in drm_stub.h... the current code is we have
discovered horribly broken in a lot of cases.. I've gotten nothing back to
say this code is any worse....

> If you want pci_driver semantics - and apparently you do - move fbdev
> and drm into a common driver or introduce a stub.  This was discussed to
> death and all kinds of list and Kernel Summit and now please follow what
> was agreed on instead of introducing subtile hacks.

Yes and that is the final goal but you are dodging the point we cannot
jump to a fully finished state in one simple transition, it is great to
hear "fbdrv/drm into a common driver" it's a simple sentence surely coding
it must be simple, well its not and we are taking the route that should
affect the least people, I'm majorly involved in the discussion and I was
the one to agree to carry out the maintenance paths between DRM and LK,
this code is needed for us to move forward with the merged drivers - if
Linus/Andrew decide not to merge it I'll go back to the DRM team and it'll
be reworked until they do accept it, but we have to stop the fb from
loading after the DRM at some stage and it may as well be earlier.. (if
2.7 was going to happen I'd wait but kernel development seems to be
changing...)

You seem to want us to go down the finished unmergeable mega-patch road
to avoid breaking something that is broken and might work, the benefits
don't outweight the costs.. so it makes no sense..

Again if Linus/Andrew bounce this we will have to rework it but something
like this has to go in at some stage...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

