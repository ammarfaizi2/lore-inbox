Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbRETTai>; Sun, 20 May 2001 15:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbRETTa2>; Sun, 20 May 2001 15:30:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14561 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262166AbRETTaQ>;
	Sun, 20 May 2001 15:30:16 -0400
Date: Sun, 20 May 2001 15:30:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Edgar Toernig <froese@gmx.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: F_CTRLFD (was Re: Why side-effects on open(2) are evil.)
In-Reply-To: <3B08149B.A28FDBD@gmx.de>
Message-ID: <Pine.GSO.4.21.0105201524310.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Edgar Toernig wrote:

> IMHO any similar powerful (and versatile) interface will see the same
> problems.  Enforcing a read/write like interface (and rejecting drivers
> that pass ptrs through this interface) may give you some knowledge about
> the kernel/userspace communication.  But the data the flows around will
> become the same mess that is present with the current ioctl.  Every driver
> invents its own sets of commands, its own rules of argument parsing, ...
> Maybe it's no longer strange binary data but readable ASCII strings but
> that's all.  Look at how many different "styles" of /proc files there are.

Too many people who don't know C and manage to get their crap into the
tree. Shame, but that is _not_ a technical problem.

> IMHO what's needed is a definition for "sane" in this context.  Trying
> to limit the kind of actions performed by ioctls is not "sane".  Then
> people will always revert back to old ioctl.  "Sane" could be: network
> transparent, architecture independant, usable with generic tools and non
> C-like languages.

/me points to UNIX-like OS that had done that. BTW, network-transparent means
"no pointers"...

