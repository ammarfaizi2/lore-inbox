Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRDSRdj>; Thu, 19 Apr 2001 13:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131562AbRDSRd3>; Thu, 19 Apr 2001 13:33:29 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:41994 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131508AbRDSRdX>;
	Thu, 19 Apr 2001 13:33:23 -0400
Date: Thu, 19 Apr 2001 13:33:47 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
Message-ID: <20010419133347.A3515@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Andreas Dilger <adilger@turbolinux.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010418233445.A28628@thyrsus.com> <200104190449.f3J4n2LF032522@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104190449.f3J4n2LF032522@webber.adilger.int>; from adilger@turbolinux.com on Wed, Apr 18, 2001 at 10:49:01PM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@turbolinux.com>:
> Could you make a list that splits the symbols up by each of the above
> failure conditions?  It would make the task of deciding how to fix the
> "problem" more apparent.

There are 32 possible categories.  I need to eyeball them and decide which
ones are significant.
 
> Also, it appears that some of the symbols you are matching are only in
> documentation (which isn't necessarily a bad thing).  I would start with:
> 
> *.[chS] Config.in Makefile Configure.help

There should be few enough of these to fit on one screen.  Over 700 dead
symbols indicates a larger problem.
 
> However, I'm not sure that your reasoning for removing these is correct.
> For example, one symbol that I saw was CONFIG_EXT2_CHECK, which is code
> that used to be enabled in the kernel, but is currently #ifdef'd out with
> the above symbol.  When Ted changed this, he wasn't sure whether we would
> need the code again in the future.  I enable it sometimes when I'm doing
> ext2 development, but it may not be worthy of a separate config option
> that 99.9% of people will just be confused about.

I think things like that don't belong in the CONFIG_ namespace to begin
with.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"To disarm the people... was the best and most effectual way to enslave them."
        -- George Mason, speech of June 14, 1788
