Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136950AbRAHF0T>; Mon, 8 Jan 2001 00:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136934AbRAHF0I>; Mon, 8 Jan 2001 00:26:08 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:30216 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S136751AbRAHFZ4>; Mon, 8 Jan 2001 00:25:56 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Nick.Holloway@pyrites.org.uk (Nick Holloway)
cc: linux-kernel@vger.kernel.org
Message-ID: <862569CE.001C2A47.00@smtpnotes.altec.com>
Date: Sun, 7 Jan 2001 22:52:48 -0600
Subject: Re: Change of policy for future 2.2 driver submissions
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Actually, I have another reason for using patch-kernel, besides being
inexperienced or lazy:  being weird.  :-)  For some reason, I have an aversion
to downloading complete kernels, and just grab the patches.  That's usually OK,
because I apply each patch one at a time, within a few hours after it comes out.
But once in a while I mess up and have to start over -- like a few days ago,
when I forgot to reverse prelease-diff before trying to apply
2.4.0-prelease-to-final.  I got the kernel source tree hosed up so badly that I
decided to blow it all away and get a clean copy.  Instead of doing the sensible
thing -- getting a fresh copy of 2.4.0 -- I untarred 2.2.16 (the most recent
tarball I had), reverse-patched it down to 2.2.8, applied patch-2.2.8-to-2.3.0,
used patch-kernel to get up to 2.3.51, then applied the patches for 2.3.99-pre1
through -pre9 and 2.4.0-test1 through -test12, and finally 2.4.0-prelease and
2.4.0-prerelease-to-final.  Sure, it's insane, but it's not as tedious as it
sounds, since I put together a script to do all this (and it doesn't take all
that long on my Pentium III, especially if I shut down X first).  Anyway, I've
kind of been hoping that now that 2.4.0 is out, maybe future patches will go
back to the x.y.z format so I could just let patch-kernel do everything.

Wayne




Nick.Holloway@pyrites.org.uk (Nick Holloway) on 01/06/2001 04:15:53 AM

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: Change of policy for future 2.2 driver submissions



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





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
