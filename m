Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVDIIBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVDIIBU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 04:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVDIIBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 04:01:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:44040 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261309AbVDIIBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 04:01:14 -0400
Date: Sat, 9 Apr 2005 10:00:56 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050409080056.GA8551@alpha.home.local>
References: <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <4256C0F8.6030008@pobox.com> <Pine.LNX.4.58.0504081114220.28951@ppc970.osdl.org> <20050408185608.GA5638@taniwha.stupidest.org> <20050409073726.GC7858@alpha.home.local> <16983.34940.197017.568255@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16983.34940.197017.568255@cse.unsw.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 05:47:08PM +1000, Neil Brown wrote:
> On Saturday April 9, willy@w.ods.org wrote:
> > 
> > I've just checked, it takes 5.7s to compare 2.4.29{,-hf3} over NFS (13300
> > files each) and 1.3s once the trees are cached locally. This is without
> > comparing file contents, just meta-data. And it takes 19.33s to compare
> > the file's md5 sums once the trees are cached. I don't know if there are
> > ways to avoid some NFS operations when everything is cached.
> > 
> > Anyway, the system does not seem much efficient on hard links, it caches
> > the files twice :-(
> 
> I suspect you'll be wanting to add a "no_subtree_check" export option
> on your NFS server...

Thanks a lot, Neil ! This is very valuable information. I didn't
understand such implications from the exports(5) man page, but it
makes a great difference. And the diff sped up from 5.7 to 3.9s
and from 19.3 to 15.3s.

Cheers,
Willy

