Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSCCUOV>; Sun, 3 Mar 2002 15:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288919AbSCCUOL>; Sun, 3 Mar 2002 15:14:11 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:27923 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S288914AbSCCUNz>;
	Sun, 3 Mar 2002 15:13:55 -0500
Date: Sat, 2 Mar 2002 14:54:53 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, mingo@elte.hu,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020302145452.A37@toy.ucw.cz>
In-Reply-To: <E16f85L-0005QM-00@wagner.rustcorp.com.au> <Pine.LNX.4.33.0202241543550.28708-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0202241543550.28708-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Feb 24, 2002 at 03:48:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >   sys_sem_create()
> > >   sys_sem_destroy()
> >
> > There is no create and destroy (init is purely userspace).  There is
> > "this is a semapore: up it".  This is a feature.
> 
> No, that's a bug.
> 
> You have to realize that there are architectures that need special
> initialization and page allocation for semaphores: they need special flags
> in the TLB for "careful access", for example (sometimes the careful access
> ends up being non-cached).

Your user part is arch-dependend, anyway. So it can just mmap(..., O_CAREFULL).

									Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

