Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVAZQHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVAZQHh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVAZQHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:07:37 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:42627 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262340AbVAZQHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:07:03 -0500
Date: Wed, 26 Jan 2005 17:06:20 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050126160620.GE23182@speedy.student.utwente.nl>
Mail-Followup-To: John Richard Moser <nigelenki@comcast.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
	Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
	marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>,
	chrisw@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org> <41F691D6.8040803@comcast.net> <Pine.LNX.4.58.0501251054400.2342@ppc970.osdl.org> <41F6A5F8.5030100@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6A5F8.5030100@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 03:03:04PM -0500, John Richard Moser wrote:
> That being said, you should also consider (unless somebody forgot to
> tell me something) that it takes two source trees to make a split-out
> patch.  The author also has to chew down everything but the feature he
> wants to split out.  I could probably log 10,000 man-hours splitting up
> GrSecurity.  :)

I'd try out Andrew's patch scripts if I were you. If you're making a patch to
the kernel, you'd best keep it in separate patches from the beginning, and
that's exactly what those scripts are very useful for.

> > It's also a lot easier to find the (inevitable) bugs. Either you already 
> > have a clue ("try reverting that one patch") or you can do things like 
> > binary searching. The bugs introduced a patch often have very little to do 
> > with the thing a patch fixes - exactly because the patch _fixes_ 
> > something, it's been tested with that particular problem, and the new 
> > problem it introduces is usually orthogonal.
> 
> true. Very very true.
> 
> With things like Gr, there's like a million features.  Normally the
> first step I take is "Disable it all".  If it still breaks, THEN THERE'S
> A PROBLEM.  If it works, then the binary searching begins.

So how do you think you would do a binary search within big patches, if it
would take you 10,000 man-hours to split up the patch? Disabling a lot of
small patches is easy, disabling a part of a big one takes a lot more work.

> > Which is why lots of small patches usually have _different_ bug behaviour
> > than the patch they fix. To go back to the A+B fix: the bug they fix may
> > be fixed only by the _combination_ of the patch, but the bug they cause is
> > often an artifact of _one_ of the patches.
> > 
> 
> Wasn't talking about bugfixes, see above.

Oh, so you're saying that security fixes don't cause bugs? Great world you live
in, then...

> > IOW, splitting the patches up makes them
> >  - easier to merge
> >  - easier to verify
> >  - easier to debug
> > 
> > and combining them has _zero_ advantages (whatever bug the combined patch
> > fix _will_ be fixed by the series of individual patches too - even if the
> > splitting was buggy in some respect, you are pretty much guaranteed of
> > this, since the bug you were trying to fix is the _one_ thing you are
> > really testing for). 
> 
> Lots of work to split up a patch though.

See above.

    Sytse
