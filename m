Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133018AbRDSThA>; Thu, 19 Apr 2001 15:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133066AbRDSTgu>; Thu, 19 Apr 2001 15:36:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16911 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133018AbRDSTgc>; Thu, 19 Apr 2001 15:36:32 -0400
Subject: Re: light weight user level semaphores
To: drepper@cygnus.com
Date: Thu, 19 Apr 2001 20:35:59 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro),
        abramo@alsa-project.org (Abramo Bagnara), alonz@nolaviz.org (Alon Ziv),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        mkravetz@sequent.com (Mike Kravetz)
In-Reply-To: <m3ofts3d4k.fsf@otr.mynet.cygnus.com> from "Ulrich Drepper" at Apr 19, 2001 12:26:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qKDi-0007sy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I fail to see how this works across processes.  How can you generate a
> file descriptor for this pipe in a second process which simply shares
> some memory with the first one?  The first process is passive: no file
> descriptor passing must be necessary.

mknod foo p. Or use sockets (although AF_UNIX sockets are higher latency)
Thats why I suggested using flock - its name based. Whether you mkstemp()
stuff and pass it around isnt something I care about

Files give you permissions for free too

> Note that semaphores need not always be shared between processes.
> This is a property the user has to choose.  So the implementation can
> be easier in the normal intra-process case.

So you have unix file permissions on them ?


