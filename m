Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317168AbSFBLVM>; Sun, 2 Jun 2002 07:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSFBLVL>; Sun, 2 Jun 2002 07:21:11 -0400
Received: from mailf.telia.com ([194.22.194.25]:39659 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S317168AbSFBLVK>;
	Sun, 2 Jun 2002 07:21:10 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <E17DMUd-0007dJ-00@starship>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jun 2002 13:21:01 +0200
Message-ID: <m2hekmgc4i.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> I wanted to know how well kbuild 2.5 really works, so I got the patches
> from kbuild.sourceforge.net and gave them a test drive, comparing to
> old kbuild.

I currently have three problems with kbuild 2.5:

1. make TAGS doesn't work.

2. NO_MAKEFILE_GEN is unsupported and therefore likely to stop working
   in future kernels. The documentation says:

        Bug reports against kbuild when you used NO_MAKEFILE_GEN will
        be ignored.

   NO_MAKEFILE_GEN is about 8.4 times faster when you want to create a
   single .o file on my 2.2GHz P4 system. It doesn't matter that much
   on a fast machine, but my old PPro 200MHz machine required
   something like 40s just to process the makefiles.

3. You have to remember the "-f Makefile-2.5" arguments to make,
   otherwise it will use the old makefile system. This seems to mess
   things up so that subsequent make commands fail.
   I tried to "mv Makefile-2.5 Makefile" to overcome this problem, but
   it doesn't work because the original Makefile appears to be needed
   for extracting kernel version information.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
