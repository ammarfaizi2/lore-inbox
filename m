Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVCFHaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVCFHaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 02:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCFHaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 02:30:13 -0500
Received: from main.gmane.org ([80.91.229.2]:14800 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261327AbVCFHaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 02:30:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andres Salomon <dilinger@voxel.net>
Subject: Re: RFD: Kernel release numbering
Date: Sun, 06 Mar 2005 02:29:42 -0500
Message-ID: <pan.2005.03.06.07.29.40.620827@voxel.net>
References: <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com> <20050303151752.00527ae7.akpm@osdl.org> <1109894511.21781.73.camel@localhost.localdomain> <20050303182820.46bd07a5.akpm@osdl.org> <1109933804.26799.11.camel@localhost.localdomain> <20050304032820.7e3cb06c.akpm@osdl.org> <1109940685.26799.18.camel@localhost.localdomain> <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-24-194-62-26.nycap.res.rr.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: ss
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clearly I picked a bad week to go on vacation..


On Fri, 04 Mar 2005
10:18:41 -0800, Linus Torvalds wrote:
[...]
> 
> Alan, I think your problem is that you really think that the tree _I_ want 
> is what _you_ want.
> 
> I look at this from a _layering_ standpoint. Not from a "stable tree"  
> standpoint at all.
> 
> We're always had the "wild" kernels, and 90% of the time the point of the
> "wild" kernels has been to let people test out the experimental stuff,
> that's not always ready for merging. Like it or not, I've considered even
> the -ac kernel historically very much a "wild" thing, not a "bugfixes" 
> thing.
> 
> What I'd like to set up is the reverse. The same way the "wild" kernels
> tend to layer on top of my standard kernel, I'd like to have a lower
> level, the "anti-wild" kernel.  Something that is comprised of patches
> that _everybody_ can agree on, and that doesn't get anything else. AT ALL.
> 

That is what I'm trying to do w/ my tree; obvious fixes only.  Most of
the patches I've included in 2.6.10-asX have been stupid build fixes, and
basic C problems (ie, deref'ing a pointer before it's been assigned).  The
main time I make exceptions for that is for security fixes.  


> And that means that such a kernel would not get all patches that you'd
> want. That's fine. That was never the aim of it. The _only_ point of
> this kernel would be to have a baseline that nobody can disagree with.
> 
> In other words, it's not a "let's fix all serious bugs we can fix", but
> a "this is the least common denominator that is basically acceptable to
> everybody, regardless of what their objectives are".
> 
> So if you want to fix a security issue, and the fix is too big or
> invasive or ugly for the "least common denominator" thing, then it
> simply does not _go_ into that kernel. At that point, it goes into an
> -ac kernel, or into my kernel, or into a vendor kernel. See?
>

This is understandable.  I have included security fixes in -as that were
non-trivial; if a 2.6.x.y tree is not willing to include them, then I
guess it won't be what I was hoping.  I had emailed Chris before going on
vacation, offering to work with him on 2.6.x.y (which would allow me to
drop -as), but if security fixes aren't a higher priority thing (even
in the face of invasive/ugly changes), then I guess there's still a need
for -as/-ac.



