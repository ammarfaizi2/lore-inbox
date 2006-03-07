Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWCGAZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWCGAZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWCGAZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:25:38 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:60539 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932520AbWCGAZh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:25:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OjCoNabt2lNE+dVdeh46BHUNcIj54KDXis5ELb8lOMqpLG0u+7OHlb0vsPDBlswEED4gf5eFynEAqEvl+CVxOvFuHQ1EBl/GrDpWKfnfOOq+VyKNj9wz/p+TmonnwqHr9BSKjIo+BpCVi+JUrVcAk0LHaOPEtFzszww0BQgJGhM=
Message-ID: <9a8748490603061625o5c9d8cf1o1873b3cc700dea75@mail.gmail.com>
Date: Tue, 7 Mar 2006 01:25:36 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       markhe@nextd.demon.co.uk, andrea@suse.de, michaelc@cs.wisc.edu,
       James.Bottomley@steeleye.com, axboe@suse.de, penberg@cs.helsinki.fi
In-Reply-To: <Pine.LNX.4.64.0603061614100.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
	 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
	 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061445350.13139@g5.osdl.org>
	 <9a8748490603061501r387291f0ha10e9e9fe3c9e060@mail.gmail.com>
	 <20060306150612.51f48efa.akpm@osdl.org>
	 <9a8748490603061524j616bf6b3i1b6ab5354bcfe1a9@mail.gmail.com>
	 <Pine.LNX.4.64.0603061614100.13139@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 7 Mar 2006, Jesper Juhl wrote:
> >
> > On 3/7/06, Andrew Morton <akpm@osdl.org> wrote:
> > > "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> > > >
> > > > And since 2.6.16-rc5-git8 is not experiencing problems I'd suggest you
> > > >  perhaps instead take a look at what's in -mm... That's where we need
> > > >  to work (it seems) to find the bug...
> > >
> > > Yes, it's very probably something in git-scsi-misc.
> > >
> > I would say that's correct. I just build 2.6.16-rc5-mm2 with just
> > git-scsi-misc.patch reverted, and that makes the problem go away.
>
> Ok. I was kind of hoping that it was just a more reliable case of the
> corruption that Andrew had been seeing too (which seems to be hard to
> trigger in mainline too, but might exist there).
>
> > So now the big question is; what part(s) of git-scsi-misc is broken?
>
> Well, its origin is actually a git tree, so you could try the "git bisect"
> approach using the
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
>
> tree that the patch comes from..
>

I'll give that a go tomorrow - right now I need to get some sleep.
If there are other things to try, then just drop me a mail and I'll
test it tomorrow.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
