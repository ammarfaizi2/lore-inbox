Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbSIXMTC>; Tue, 24 Sep 2002 08:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbSIXMTC>; Tue, 24 Sep 2002 08:19:02 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:32778 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261659AbSIXMTB>; Tue, 24 Sep 2002 08:19:01 -0400
Date: Tue, 24 Sep 2002 13:23:57 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@sgi.com>, bobm@fc.hp.com, phil.el@wanadoo.fr,
       torvalds@transmeta.com
Subject: Re: [PATCH][RFC] oprofile 2.5.38 patch
Message-ID: <20020924122357.GA52643@compsoc.man.ac.uk>
References: <20020923222933.GA33523@compsoc.man.ac.uk> <20020924144838.A1144@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020924144838.A1144@sgi.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17tojN-000CKt-00*ujeotXP4B7k* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 02:48:38PM -0400, Christoph Hellwig wrote:

> [snip config bits]

Thanks.

> OTOH I wonder whether you really want an submenu.  It could as well just
> be part of the general settings one.

I was a bit dubious it might be hard to find. It's not particularly
general ...

> Usually <foo>-objs is below obj-*, but that's just cosmetic.  The Makefile
> inclusion seems very wrong to me.  Why do you need it?

It's by far the simplest way to build the single module target...

> Shouldn't drivers/oprofile/i386/ be arch/i386/oprofile??

Perhaps. I kind of liked the code to be together. Also I wasn't sure how
I could convince kbuild to make a single target from the disparate dirs.
Kai mentioned that XFS does something similar, I'll look into that ...

> Why is this copyright different from the others?

Perils of very similar vim iab's ... fixed

> Why don't you just set no write method at all?

OK.

> Maybe oprofilefs wants to become a generic version, it has nothing
> oprofile-specific..

I don't know what you mean here. Do you mean hooking into driverfs ?
Last I checked it wasn't suitable for such oddball minifs's.

> Please use cond_syscall() and compile that file only for CONFIG_PROFILING set.

Ah, thanks.

> +       struct dcookie_struct * d_cookie; /* cookie, if any */
> 
> Make that conditional on CONFIG_PROFILING?

And same for the task_struct field. Will do.

> Put that exports into profile.c?

Sure.

thanks
john
