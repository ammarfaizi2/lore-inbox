Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLPM2H>; Sat, 16 Dec 2000 07:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLPM16>; Sat, 16 Dec 2000 07:27:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28074 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129345AbQLPM1r>;
	Sat, 16 Dec 2000 07:27:47 -0500
Date: Sat, 16 Dec 2000 06:57:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Miquel van Smoorenburg <miquels@cistron.nl>
cc: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: TIOCGDEV ioctl
In-Reply-To: <20001216124011.A14129@cistron.nl>
Message-ID: <Pine.GSO.4.21.0012160652150.15518-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Miquel van Smoorenburg wrote:

> According to Alexander Viro:
> > OK, I can see the point of finding out where the console is redirected
> > to. How about the following:
> > 
> > 	/proc/sys/vc -> /dev/tty<n>
> > 	/proc/sys/console -> where the hell did we redirect it or
> > 			     vc if there's no redirect right now
> > Will that be OK with you?
> 
> Well, I'd prefer the ioctl, but I can see the general direction the
> kernel is heading to: get rid of numeric ioctls and sysctl()s and
> put all that info under /proc.
> 
> However /proc/sys only contains directories now, it would look

Huh? Oh, sorry. /proc/tty, indeed - it was a braino. BTW, I think
that a mini-fs with a device node for each registered console +
symlink (say it, "default") pointing to the default one might make
sense too. Comments?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
