Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWCGASZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWCGASZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWCGASZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:18:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43995 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932502AbWCGASY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:18:24 -0500
Date: Mon, 6 Mar 2006 16:17:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       markhe@nextd.demon.co.uk, andrea@suse.de, michaelc@cs.wisc.edu,
       James.Bottomley@steeleye.com, axboe@suse.de, penberg@cs.helsinki.fi
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <9a8748490603061524j616bf6b3i1b6ab5354bcfe1a9@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603061614100.13139@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com> 
 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com> 
 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com> 
 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org> 
 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com> 
 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>  <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
  <Pine.LNX.4.64.0603061445350.13139@g5.osdl.org> 
 <9a8748490603061501r387291f0ha10e9e9fe3c9e060@mail.gmail.com> 
 <20060306150612.51f48efa.akpm@osdl.org> <9a8748490603061524j616bf6b3i1b6ab5354bcfe1a9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Mar 2006, Jesper Juhl wrote:
>
> On 3/7/06, Andrew Morton <akpm@osdl.org> wrote:
> > "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> > >
> > > And since 2.6.16-rc5-git8 is not experiencing problems I'd suggest you
> > >  perhaps instead take a look at what's in -mm... That's where we need
> > >  to work (it seems) to find the bug...
> >
> > Yes, it's very probably something in git-scsi-misc.
> >
> I would say that's correct. I just build 2.6.16-rc5-mm2 with just
> git-scsi-misc.patch reverted, and that makes the problem go away.

Ok. I was kind of hoping that it was just a more reliable case of the 
corruption that Andrew had been seeing too (which seems to be hard to 
trigger in mainline too, but might exist there).

> So now the big question is; what part(s) of git-scsi-misc is broken?

Well, its origin is actually a git tree, so you could try the "git bisect" 
approach using the

	git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

tree that the patch comes from..

		Linus
