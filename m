Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbSLQTvX>; Tue, 17 Dec 2002 14:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267005AbSLQTvX>; Tue, 17 Dec 2002 14:51:23 -0500
Received: from mail.zmailer.org ([62.240.94.4]:9183 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S266308AbSLQTvW>;
	Tue, 17 Dec 2002 14:51:22 -0500
Date: Tue, 17 Dec 2002 21:59:17 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, Ulrich Drepper <drepper@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217195917.GA32122@mea-ext.zmailer.org>
References: <3DFF7951.6020309@transmeta.com> <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 11:37:04AM -0800, Linus Torvalds wrote:
> On Tue, 17 Dec 2002, H. Peter Anvin wrote:
> > Let's see... it works fine on UP and on *most* SMP, and on the ones
> > where it doesn't work you just fill in a system call into the vsyscall
> > slot.  It just means that gettimeofday() needs a different vsyscall slot.
> 
> The thing is, gettimeofday() isn't _that_ special. It's just not worth a
> vsyscall of it's own, I feel. Where do you stop? Do we do getpid() too?
> Just because we can?

  clone()   -- which doesn't really like anybody using stack-pointer ?

  (I do use  gettimeofday() a _lot_, but I have my own userspace
   mapped shared segment thingamajingie doing it..  And I write
   code that runs on lots of systems, not only at Linux. )

> 		Linus

/Matti Aarnio
