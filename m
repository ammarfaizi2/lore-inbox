Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277394AbRJEOix>; Fri, 5 Oct 2001 10:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277398AbRJEOiu>; Fri, 5 Oct 2001 10:38:50 -0400
Received: from ns.suse.de ([213.95.15.193]:42505 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277394AbRJEOhj>;
	Fri, 5 Oct 2001 10:37:39 -0400
Date: Fri, 5 Oct 2001 16:38:07 +0200
From: Andi Kleen <ak@suse.de>
To: Padraig Brady <padraig@antefacto.com>
Cc: Andi Kleen <ak@suse.de>, Alex Larsson <alexl@redhat.com>,
        Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
Message-ID: <20011005163807.A13524@gruyere.muc.suse.de>
In-Reply-To: <m3r8slywp0.fsf@myware.mynet> <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com> <20011003232609.A11804@gruyere.muc.suse.de> <3BBDAB24.7000909@antefacto.com> <20011005150144.A11810@gruyere.muc.suse.de> <3BBDB26D.2050705@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BBDB26D.2050705@antefacto.com>; from padraig@antefacto.com on Fri, Oct 05, 2001 at 02:15:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Another advantage of using the real time instead of a counter is that 
> >you can easily merge the both values into a single 64bit value and do
> >arithmetic on it in user space. With a generation counter you would need 
> >to work with number pairs, which is much more complex. 
> >
> ??
> if (file->mtime != mtime || file->gen_count != gen_count)
>      file_changed=1;

And how would you implement "newer than" and "older than" with a generation
count that doesn't reset in a always fixed time interval (=requiring
additional timestamps in kernel)?  

-Andi

