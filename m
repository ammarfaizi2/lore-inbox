Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUEWRGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUEWRGv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUEWRGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:06:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:13535 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263173AbUEWRGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:06:49 -0400
Date: Sun, 23 May 2004 10:06:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission 
In-Reply-To: <200405231633.i4NGXHv18935@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.58.0405230955580.25502@ppc970.osdl.org>
References: <200405231633.i4NGXHv18935@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 May 2004, Horst von Brand wrote:
> 
> > So, to avoid these kinds of issues ten years from now, I'm suggesting that 
> > we put in more of a process to explicitly document not only where a patch 
> > comes from (which we do actually already document pretty well in the 
> > changelogs), but the path it came through. 
> 
> How will the path be preserved? Does BK do it now? Can it be transferred
> into CVS (for paranoid CVS-won't-screw-us-ever people)?

It will just be in the changelog comments, so yes, BK will preserve it.

The path _inside_ BK is different - BK won't update the changelog 
comments, so basically once it hits BK (or any other SCM, for that 
matter), it's up to the SCM to save off the path details. BK does this by 
recording who committed something, and recording merges, so the 
information still exists, but it's no longer in the same format.

> Does this mean that only the repositories contain the certificates,
> "final source" doesn't?

Well, if you use some format that doesn't preserve patch boundaries (like
exporting it to a plain tar-file), then clearly you can't save the patch
submission details either. So yes, if you use just plain CVS to export it,
or do a "bk export -tplain", the information will be gone.  I don't see
how you _could_ save the information at that point - you're literally
asking to "flatten" the submission tree.

> Just make sure the relevant open source licenses are in Documentation, and
> so is the Certificate du jour.

Yes, I was planning on adding it to Documentation, and also putting a big 
pointer to it into Documentation/SubmittingPatches. But this is obviously 
not something I can do unilaterally, so first we'd all need to agree that 
it's a good idea to do this process.

BTW - there are later stages that I would like to do, like having
automated "acknowledgement" emails sent out when a patch hits the main
repository. The same way that people now have robots that send out the
full patches to the patch lists when a patch hits the kernel.org
repository, we can use this thing to have people who have signed up for
acknowledgement be notified each time a patch that they signed off on hits
the repository.

Not everybody will necessarily care, but I know some people have asked for
a positive ack on when their patch finally hits the "official" trees, and
this sign-off procedure would put all the infrastructure in place for
automating that kind of service.

		Linus
