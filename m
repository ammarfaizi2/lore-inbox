Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271070AbRHOG74>; Wed, 15 Aug 2001 02:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271071AbRHOG7q>; Wed, 15 Aug 2001 02:59:46 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:18073 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S271070AbRHOG7d>; Wed, 15 Aug 2001 02:59:33 -0400
Message-Id: <200108150659.f7F6xeh16394@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: J Sloan <jjs@pobox.com>, dmaynor@iceland.oit.gatech.edu
Subject: Re: 2.4.8 Resource leaks + limits
Date: Wed, 15 Aug 2001 02:59:40 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3ce801c12548$b7971750$020a0a0a@totalmef> <20010815014328.A15395@iceland.oit.gatech.edu> <3B7A0F01.DC4CAE4@pobox.com>
In-Reply-To: <3B7A0F01.DC4CAE4@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably both -- he's thinking more about the userspace side of it, though.

Since you want these settings to vary by user and persist across reboots, 
the default levels will need to be stored in some table/database and /etc 
seems like the appropriate place.  Of course, that's more PAM's domain 
than a kernel issue, but the userspace connection is still important.

Will there be a utility for viewing/changing per-user limits?  If so, what 
should it be called?  Will we just pile more values into ulimit?  We're 
running a little short on intuitive flags.

/proc entries are okay for tweaking kernel parameters, but it seems a 
little weak as a primary interface.  You might as well have ps say 'Go 
grep it yourself!'

	-- Brian

On Wednesday 15 August 2001 01:56 am, J Sloan wrote:
> dmaynor@iceland.oit.gatech.edu wrote:
> > > This is why you mainly find per-process stuff in all the limits.
> > >
> > > Linux has had (for a while now) a "struct user" that is actually
> > > quickly accessible through a direct pointer off every process that
> > > is associated with that user, and we could (and _will_) start adding
> > > these kinds of limits. However, part of the problem is that because
> > > the limits haven't historically existed, there is also no accepted
> > > and nice way of setting the limits.
> >
> > So when you do impose this, where will it be setable, will there be a
> > flat file in /etc like solaris, or compile time for the kernel?
>
> Eh?
>
> Why wouldn't it be like most parameters in Linux,
> e.g. dynamically adjustable via a sysctl or /proc?
>
> IMHO, of course...
>
> cu
>
> jjs
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
