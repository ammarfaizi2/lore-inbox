Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263430AbRFNRdR>; Thu, 14 Jun 2001 13:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263432AbRFNRdH>; Thu, 14 Jun 2001 13:33:07 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:2286 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S263430AbRFNRcw>;
	Thu, 14 Jun 2001 13:32:52 -0400
Date: Thu, 14 Jun 2001 10:32:49 -0700
From: Richard Henderson <rth@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: unregistered changes to the user<->kernel API
Message-ID: <20010614103249.A28852@redhat.com>
In-Reply-To: <20010614191219.A30567@athlon.random> <20010614191634.B30567@athlon.random> <20010614192122.C30567@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010614192122.C30567@athlon.random>; from andrea@suse.de on Thu, Jun 14, 2001 at 07:21:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 07:21:22PM +0200, Andrea Arcangeli wrote:
> Richard are you sure we can break O_NOFOLLOW and still expect the machine to
> boot?
[uses in glibc]

Yes, I saw those.  What is the effect of O_NOFOLLOW?  To not
follow symbolic links when opening the file.  If you open a
regular file, in effect nothing happens.  Moreover, if these
opens were not finding files now, the system wouldn't work.

So: the effect, I suppose, is (1) disabling some security
within glibc, and (2) making these accesses slower since they
will be considered O_DIRECT after the change.

Which doesn't seem that life-threatening to me.


r~
