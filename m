Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288662AbSANCTg>; Sun, 13 Jan 2002 21:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288668AbSANCTR>; Sun, 13 Jan 2002 21:19:17 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:52498 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288662AbSANCTC>; Sun, 13 Jan 2002 21:19:02 -0500
Message-ID: <3C423EB9.1E7A933E@zip.com.au>
Date: Sun, 13 Jan 2002 18:13:13 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Burns <patrickb@vrlaw.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops in kswapd (Kernel 2.4.17)
In-Reply-To: <3C423A90.2E34D426@vrlaw.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Burns wrote:
> 
> Is there some kind of memory problem with kernel 2.4.17? I noticed in an
> article at:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101096234600708&w=2
> 
> and another at:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0201.1/0809.html
> 
> that people were getting oopses in kswapd.

One does begin to think that there may be a problem.  The inode,
dentry and buffer caches do involve a lot of pointer chasing,
and do tend to expose hardware problems (memory), and we've tended
to assume that's the reason for all the reports.

But there are a *lot* of reports, and the same argument applies:
the long pointer chases will expose random memory corruption caused
by a kernel bug.

It's starting to look fishy.

-
