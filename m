Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270263AbRIAOPF>; Sat, 1 Sep 2001 10:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270712AbRIAOOz>; Sat, 1 Sep 2001 10:14:55 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:43530 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270263AbRIAOOf>; Sat, 1 Sep 2001 10:14:35 -0400
Date: Sat, 1 Sep 2001 16:15:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "G. Hugh Song" <ghsong@norma.kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre2aa2
Message-ID: <20010901161517.C927@athlon.random>
In-Reply-To: <3B90C0D4.6010509@norma.kjist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B90C0D4.6010509@norma.kjist.ac.kr>; from ghsong@norma.kjist.ac.kr on Sat, Sep 01, 2001 at 08:04:52PM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2001 at 08:04:52PM +0900, G. Hugh Song wrote:
> Dear Andrea,
> 
> Since sometime around 2.4.7-*aa*, I never succeeded booting from your
> patched kernel on UP2000 dual with SuSE-7.1 with 2GB memory.
> 
> Booting stops somewhere near the file system check.  The stopping place
> is not always the same.  Today I compiled 2.4.10pre2aa2.  It stopped
> while reading the /lib/modules/2.4.10pre2aa2.
> 
> I attached .config here.
> 
> Am I the only one having trouble with the recent *aa*-series kernel?
> 
> The last time I succeeded, I had 2.4.5pre2aa1.  I attached the xconfig
> file also.

Can you try to backout those two patches in order before compiling?

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre2aa2/71_mmap-rb-6_other-archs-1
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre2aa2/70_mmap-rb-6

I also cannot boot 2.4.10pre2aa2 on my alpha box :(, I nailed it down
due the mmap-rb vma lookup rewrite, however it is quite strange that it
is generating problems because it's at 99% common code stuff. I will try
to fix it ASAP. In the meantime make sure to backout those two patches
when you run it on alpha (such two patches never generated a single
problem on x86 yet AFIK).

Andrea
