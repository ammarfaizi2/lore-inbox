Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUJTOmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUJTOmj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUJTOjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:39:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:37325 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266680AbUJTOdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:33:53 -0400
Date: Wed, 20 Oct 2004 07:33:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
In-Reply-To: <1098256951.26595.4296.camel@d845pe>
Message-ID: <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org>
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Oct 2004, Len Brown wrote:
>
> On Wed, 2004-10-20 at 02:49, Benjamin Herrenschmidt wrote:
> > 
> > After you tag a "release" tree in bk, could you bump the version
> > number right away, with eventually some junk in EXTRAVERSION like
> > "-devel" ?
> 
> I'd find this to be really helpful too.  There has been this period
> between, say, 2.6.9 and 2.6.10-whatever where my build/install scripts
> scribble over my "reference" kernels.

Personally, I much rather go the way we have gone, because I don't care
about module versioning nearly as much as I care about bug-report
versioning. And if I hear about a bug with 2.6.10-rc1, I want to know that
it really is at _least_ 2.6.10-rc1, if you see what I mean..

Now, personally, I'd actually like to know the exact top-of-tree
changeset, so I've considered having something that saves that one away,
but then we'd need to do something about non-BK users (make the nightly 
snapshots squirrell it away somewhere too). That would solve both the 
module versioning _and_ the bug-report issue.

So if somebody comes up with a build script that generates that kind of 
extra-version automatically, I'm more receptive. But I don't want to muck 
with the version manually in a way that I think is the wrong way around..

		Linus
