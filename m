Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287550AbSAHBV6>; Mon, 7 Jan 2002 20:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287588AbSAHBVs>; Mon, 7 Jan 2002 20:21:48 -0500
Received: from svr3.applink.net ([206.50.88.3]:54532 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287550AbSAHBVf>;
	Mon, 7 Jan 2002 20:21:35 -0500
Message-Id: <200201080120.g081KKSr014891@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Christoph Hellwig <hch@ns.caldera.de>,
        abramo@alsa-project.org (Abramo Bagnara)
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
Date: Mon, 7 Jan 2002 19:16:36 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jaroslav Kysela <perex@suse.cz>,
        sound-hackers@zabbo.net, linux-sound@vger.rutgers.edu,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <200201072125.g07LPgE02318@ns.caldera.de>
In-Reply-To: <200201072125.g07LPgE02318@ns.caldera.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 January 2002 15:25, Christoph Hellwig wrote:
> In article <3C39E6A0.34A88990@alsa-project.org> you wrote:
> > If you want to keep top level cleaner and avoid proliferation of entries
> > we might have:
> >
> > subsys/sound
> > subsys/sound/drivers
> > subsys/net
> > subsys/net/drivers
>
> And what part of the kernel is no subsystem?
> Your subsystem directory is superflous.

Umm, the subsys part makes a lot of sense in terms of
logically separating the core of the kernel from the 
architecture part and the subsystem part.    While we 
need a MM to complete a kernel, we certainly don't need 
"subsys/sound/alsa/driver/es1371.c".

.
./arch
./fs
./init
./kernel
./lib
./mm
./include
./ipc
./subsys
./scripts
./Documentation


If this helps make the kernel source more like the modules
and devfs trees, then it makes even it more logically consistant.


Please remember that everyone who compiles a kernel is not
a uber kernel hacker.   Average folks will appreciate some more
structure which helps to explain how things work.

>
> If, for some reason, we want to move all code in the kernel around
> we should do it once and in a planned mannor.
>
> Randomly introducing new and shiny naming schemes sucks.  badly.

It's NOT random and it doesn't suck.

>
> 	Christoph

-- 
timothy.covell@ashavan.org.
