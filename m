Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130051AbRCAV0c>; Thu, 1 Mar 2001 16:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130043AbRCAV0X>; Thu, 1 Mar 2001 16:26:23 -0500
Received: from mail0.netcom.net.uk ([194.42.236.2]:36532 "EHLO
	mail0.netcom.net.uk") by vger.kernel.org with ESMTP
	id <S130051AbRCAV0M>; Thu, 1 Mar 2001 16:26:12 -0500
Message-ID: <3A9EBE7F.2DFF728E@netcomuk.co.uk>
Date: Thu, 01 Mar 2001 21:26:23 +0000
From: Bill Crawford <billc@netcomuk.co.uk>
Organization: Netcom Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
CC: Alexander Viro <viro@math.psu.edu>, Pavel Machek <pavel@suse.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
In-Reply-To: <Pine.GSO.4.21.0103011547200.11577-100000@weyl.math.psu.edu> <3A9EB984.C1F7E499@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Before I reply: I apologise for starting this argument, or at least
making it worse, and please let me say again that I really would like
to see improvements in directory searching etc. ... my original point
was simply a half-joking aside to the effect that we should not
encourage people to put thousands of files in a single directory ...

"H. Peter Anvin" wrote:

> >         * userland issues (what, you thought that limits on the
> > command size will go away?)

> Last I checked, the command line size limit wasn't a userland issue, but
> rather a limit of the kernel exec().  This might have changed.

 Actually this is also a serious problem.  We have a ticketing system
at work that stores all its data in files in large directories, and I
discovered recently that I can only pass about a tenth of the current
file names on a command line.  Yes, we have xargs, but ...

 Also (this happens to be Solaris on a 8 x 40MHz Sparc system) there
is a significant delay just to read the directory.

> >         * portability

 Also an issue.  Fortunately we store a lot of data on NetApps, so
the performance of the filesystem as such is less of an issue; but,
that means the size of the data transfer across the network involved 
in reading a directory can become an issue too.

> > The point being: applications and users _do_ know better what structure
> > is there. Kernel can try to second-guess them and be real good at that, but
> > inability to second-guess is the last of the reasons why aforementioned
> > strategies are used.

 All good points ...

> However, there are issues where users and applications don't want to
> structure their namespace for the convenience of the kernel, for good or
> bad reasons.

 But there are other reasons (besides the kernel's and filesystems'
handling of directories and name lookups).  I think you're spot on
about the performance issues and on-disk structures, though.

>         -hpa

-- 
/* Bill Crawford, Unix Systems Developer, ebOne, formerly GTS Netcom */
#include "stddiscl.h"
