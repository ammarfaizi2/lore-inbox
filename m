Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTLEEeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 23:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTLEEeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 23:34:12 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:167 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263166AbTLEEeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 23:34:09 -0500
Date: Fri, 5 Dec 2003 15:32:17 +1100
From: Nathan Scott <nathans@sgi.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Mihai RUSU <dizzy@roedu.net>
Subject: Re: Errors and later panics in 2.6.0-test11.
Message-ID: <20031205043217.GA1990@frodo>
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org> <200312031747.16927.ender@debian.org> <Pine.LNX.4.58.0312030916080.6950@home.osdl.org> <20031204124342.GD1086@suse.de> <20031204140738.GE1086@suse.de> <16335.63095.266710.554162@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16335.63095.266710.554162@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 02:07:35PM +1100, Neil Brown wrote:
> On Thursday December 4, axboe@suse.de wrote:
> > 
> > I can just as easily reproduce with ext2, so I don't think XFS has
> > anything to do with it. This is still raid5 with dm linear on top.
> > 
> 
> Thanks.  The more evidence the better....
> 
> After staring at the code over and ove again, I finally saw the
> assumption that I was making that was invalid.  I also found a
> possible data-corruption bug in the process.
> 
> If you have been having problems with raid5, please try this patch and
> see if it helps.

Yes, thats fixed it.  That reproducible test case I had no longer
shows any problems.

cheers.

-- 
Nathan
