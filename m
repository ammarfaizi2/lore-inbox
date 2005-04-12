Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVDLRmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVDLRmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVDLRmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:42:23 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:54284 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262500AbVDLRaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:30:24 -0400
Date: Tue, 12 Apr 2005 19:34:26 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: tony.luck@intel.com, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
Message-ID: <20050412173426.GA17053@hh.idb.hist.no>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <200504101200.j3AC0Mu13146@unix-os.sc.intel.com> <Pine.LNX.4.58.0504100854110.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504100854110.1267@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 09:01:22AM -0700, Linus Torvalds wrote:
> 
> So I was for a while debating having a totally flat directory space, but 
> since there are _some_ downsides (linear lookup for cold-cache, and just 
> that "ls -l" ends up being O(n**2) and things), I decided that a single 
> fan-out is probably a good idea.
> 
Isn't that fixed even in ext2/ext3 these days?

man mke2fs:
                   dir_index
                          Use  hashed  b-trees  to  speed  up lookups in large
                          directories.

Also, the popular reiserfs was designed with this in mind from the start.


> > Or maybe the files should be named objects/xx/yy/zzzzzzzzzzzzzzzz?
> 
> Hey, I may end up being wrong, and yes, maybe I should have done a 
> two-level one. 

Unless there still is performance issues, please don't.  A directory
structure with extra levels is necessarily harder to use if one
ever have to use it manually somehow.

Helge Hafting 

