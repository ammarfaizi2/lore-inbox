Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSJRLcI>; Fri, 18 Oct 2002 07:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265075AbSJRLcI>; Fri, 18 Oct 2002 07:32:08 -0400
Received: from unthought.net ([212.97.129.24]:54455 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S265074AbSJRLcH>;
	Fri, 18 Oct 2002 07:32:07 -0400
Date: Fri, 18 Oct 2002 13:38:06 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Device-mapper submission 6/7
Message-ID: <20021018113806.GD7875@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Joe Thornber <joe@fib011235813.fsnet.co.uk>, Andi Kleen <ak@muc.de>,
	linux-kernel@vger.kernel.org
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk> <3DAD75AE.7010405@pobox.com> <20021016152047.GA11422@fib011235813.fsnet.co.uk> <3DAD8CC9.9020302@pobox.com> <20021017080552.GA2418@fib011235813.fsnet.co.uk> <m3fzv5pj23.fsf@averell.firstfloor.org> <20021017085045.GA2651@fib011235813.fsnet.co.uk> <3DAEEB59.2000000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DAEEB59.2000000@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 12:54:49PM -0400, Jeff Garzik wrote:
...
> Preferred method of data input is always ASCII, but if that is 
> unreasonable, make sure your binary data is fixed-endian and fixed-size 
> on all architectures.

But Jeff, won't the kernel end up with a myriad of
sort-of-similar-but-all-different parsers, with each their set of
overflows, *(int*)0, etc. etc. ??

This sounds like /proc - just the other way around. Today the kernel
generates everything from one-value-per-file to friggin ASCII art in
it's proc files, and userspace is cluttered beyond belief with myriads
of parsers, sort of similar but all different.

And now you want parsers in the kernel?  Not just a few, but like
*myriads*...

I really like the idea with having
  mv  volume1 volume42
as a way of renaming a volume.

Compare that to
  echo "rename-volume volume1 volume42" > volume_command_file

I doubt that there will be much that cannot be mapped to standard
filesystem semantics. Plan9 has TCP *connections* as files...

At least I think that this should be considered thoroughly. I fear that
we will end up with something worse than procfs in a year from now, if
the current trend is "just make a command file and a parser in the
kernel" now.

Just my 0.02 Euro.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
