Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263605AbRFNSKS>; Thu, 14 Jun 2001 14:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263597AbRFNSKH>; Thu, 14 Jun 2001 14:10:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1962 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263595AbRFNSKC>;
	Thu, 14 Jun 2001 14:10:02 -0400
Date: Thu, 14 Jun 2001 14:10:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Henderson <rth@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: unregistered changes to the user<->kernel API
In-Reply-To: <20010614103249.A28852@redhat.com>
Message-ID: <Pine.GSO.4.21.0106141406200.6049-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jun 2001, Richard Henderson wrote:

> Yes, I saw those.  What is the effect of O_NOFOLLOW?  To not
> follow symbolic links when opening the file.  If you open a
> regular file, in effect nothing happens.  Moreover, if these
> opens were not finding files now, the system wouldn't work.
> 
> So: the effect, I suppose, is (1) disabling some security
> within glibc, and (2) making these accesses slower since they
> will be considered O_DIRECT after the change.
> 
> Which doesn't seem that life-threatening to me.

O_NOFOLLOW is used to deal with symlink attacks. Breaking it means
that for quite a few binaries you are opening security holes. And
since it's a flagday change, you'll get the situation when no version
will work for all kernels. Bad idea, IMO.

