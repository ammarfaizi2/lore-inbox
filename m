Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAFKQW>; Sat, 6 Jan 2001 05:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbRAFKQN>; Sat, 6 Jan 2001 05:16:13 -0500
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:38417 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129431AbRAFKQB>; Sat, 6 Jan 2001 05:16:01 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: Change of policy for future 2.2 driver submissions
Date: 6 Jan 2001 10:15:53 -0000
Organization: Alfie's Internet Node
Message-ID: <936r8p$3ns$1@alfie.demon.co.uk>
In-Reply-To: <862569CB.0070DDEE.00@smtpnotes.altec.com>
X-Newsreader: NN version 6.5.0 CURRENT #119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <862569CB.0070DDEE.00@smtpnotes.altec.com> Wayne.Brown@altec.com writes:
> Either I'm blind, or especially dense today, or both (quite possible :-) but I
> don't see any reference in patch-kernel to the extra version information.
> EXTRAVERSION is defined in the kernel Makefile, and I tried using the script
> found in the 2.4.0-test1 source like this:
> 
> patch-kernel /usr/src/linux /pub/linux/kernel/v2.4/test-kernels
> 
> but the test-2 and following patches are not applied.  All I get is "Current
> kernel version is 2.4.0."  What am I missing?

The distributed version of patch-kernel has only ever known about the
"standard" progression x.y.z => x.y.z+1.  This all gets horribly broken
when Linus gets imaginative with his kernel numbering.

I have said before that I thought this was OK, because the people that
need to cope with the EXTRAVERSION guff are people on the development
branch, and should be able to patch the kernel themselves.  The main
users of patch-kernel are less experienced people.

However, this does conflict with the aim of getting users into testing
kernels late in the development branch cycle.  It also affects people
like me who are lazy.

I don't think that getting the kernel version to support the naming scheme
du-jour will work, as this would require Linus to update patch-kernel
when he dreams up a new scheme -- and Linus is the one person I'm fairly
sure does not use it!

For myself, I have a version of patch-kernel that does know how to deal
with the wacky naming versions (because I'm lazy).  In future I'll make
this available to anyone that wants to download it for their own use,
but I won't push to get it included.

A (temporary) location for the current version is:

	http://www.alfie.demon.co.uk/download/patch-kernel

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
