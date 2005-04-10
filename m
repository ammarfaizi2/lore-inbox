Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVDJWNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVDJWNI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 18:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVDJWNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 18:13:07 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:26364 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261618AbVDJWMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 18:12:48 -0400
Date: Sun, 10 Apr 2005 15:03:31 -0400
From: Christopher Li <lkml@chrisli.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@engr.sgi.com>, junkio@cox.net, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-ID: <20050410190331.GG13853@64m.dyndns.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org> <20050410115055.2a6c26e8.pj@engr.sgi.com> <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 01:57:33PM -0700, Linus Torvalds wrote:
> 
> > That way of thinking really doesn't work well here.
> > 
> > I will have to look more closely at pasky's GIT toolkit
> > if I want to see an SCM style interface.
> 
> Yes. You really should think of GIT as a filesystem, and of me as a 
> _systems_ person, not an SCM person. In fact, I tend to detest SCM's. I 
> think the reason I worked so well with BitKeeper is that Larry used to do 
> operating systems. He's also a systems person, not really an SCM person. 
> Or at least he's in between the two.
> 

Yes, I am puzzled for a while how to use git until I realize that it is
a version file system.

BTW, one thing I learn from ext3 is that it is very useful to have some
compatible flag for future development. I think if we want to reserve some
room in the file format for further development of git, it is the right time
to do it before it get bigs. e.g. an optional variable size header in "tree"
including format version and capability etc. I can see the counter argument
that it is not as important as a real file system because it is a lot easier
bring it off line to upgrade the whole tree.

One the other hand, it is almost did not cost any thing in terms of space and
CPU time, most directory did not get to file system block boundary so extra few bytes
is almost free. If carefully planed, it will make the future up grade of git
a lot smoother.

What do you think?

Chris

