Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbUK0EAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbUK0EAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbUK0EAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:00:38 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41923 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262368AbUKZTaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:04 -0500
Date: Thu, 25 Nov 2004 10:54:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Hudec <bulb@ucw.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, avi@argo.co.il,
       alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041125095407.GA1014@elf.ucw.cz>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <20041125062649.GB29278@vagabond> <E1CXE4k-0000Ow-00@dorka.pomaz.szeredi.hu> <20041125074741.GC29278@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125074741.GC29278@vagabond>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Of course I believe, that it's probably easier to tweak the page cache
> > to teach it that fuse pages _can_ be written back, but not reliably
> > like a disk filesystem.  And there's the small problem of limiting the
> > number of writable pages allocated to FUSE.
> 
> It's not that easy. How do you tell when the page is no longer likely to
> get cleaned?
> 
> The file backing would be easier, but to be really easy, the interface
> would be a bit different (and actualy simpler, since it would need no
> data channel, just a control one).
> 
> The trick is, that the coda file-granularity interface is not that hard
> to extend to page-granularity. Several filesystems allow "files with
> holes". So the fuse process could just touch a file and truncate it to
> desired length on open. Then kernel would tell it which pages it wants
> and the process would acknowledge when they are actualy filled. For
> write, kernel would just notify the process of dirty ranges and what --
> and when -- the process does with that is not kernel's business.

Well, it would work fine and nice... until you want to export file
with holes with fuse. That probably could be made to work, but...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
