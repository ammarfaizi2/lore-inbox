Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S161057AbQG1Ut0>; Fri, 28 Jul 2000 16:49:26 -0400
Received: by vger.rutgers.edu id <S161062AbQG1Uri>; Fri, 28 Jul 2000 16:47:38 -0400
Received: from cr355197-a.poco1.bc.wave.home.com ([24.112.113.88]:61469 "EHLO whiskey.fireplug.net") by vger.rutgers.edu with ESMTP id <S161109AbQG1Upq>; Fri, 28 Jul 2000 16:45:46 -0400
To: linux-kernel@vger.rutgers.edu
Path: whiskey.fireplug.net!not-for-mail
From: sl@whiskey.fireplug.net (Stuart Lynne)
Newsgroups: list.linux-kernel
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 28 Jul 2000 13:56:40 -0700
Organization: fireplug
Distribution: local
Message-ID: <8lss28$v2e$1@whiskey.fireplug.net>
References: <Pine.LNX.4.21.0007280808460.73-100000@rc.priv.hereintown.net>
Reply-To: sl@fireplug.net
Sender: owner-linux-kernel@vger.rutgers.edu

In article <Pine.LNX.4.21.0007280808460.73-100000@rc.priv.hereintown.net>,
Chris Meadors <clubneon@hereintown.net> wrote:
>On Thu, 27 Jul 2000, Thomas Molina wrote:
>
>> No I'm not kidding.  Based on some comments by Linus earlier, he is
>> advocating putting the kernel source tree out of the way of glibc and
>> other "standard" development tools.  /usr/local seems a better fit to me
>> than /lib/modules.  According to FHS /lib is for essential shared
>> libraries and kernel modules.  It also says one of the uses of
>> /usr/local is for local source code.  It's also one of the few places
>> which shouldn't get clobbered in a system software upgrade.
>
>FHS also says that a distro should ship with nothing in the /usr/local
>tree.
>
>But the FHS also says you can't have things like /usr/apache.  But I find
>that most useful, as deleting one directory removes all traces of the
>program.  Large packages that would normally end up all over the place can
>be contained (like X, which FHS does allow to have its own place under
>/usr).

You can do that in /opt or /usr/local if you like. 

>> It was an opinion; I'm expressing my 'druthers, if you will.  I know
>> others don't agree.  I see where it looks as if Linus is leaning towards
>> /lib/modules anyway, so I'll adapt.  Or I'll be contrary and make
>> appropriate local changes in the source code.  As long as Linus keeps it
>> as a self-contained entity it won't matter anyway.
>
>/lib/modules seems good enough.  But as somone else said, it might make
>more sence to be /lib/kernel.  The one problem I see with this, is I
>usually have a small(ish) root partition.  On any installation I've done
>/lib has never had its own partition.  And on most, the root partition
>hasn't been big enough to hold an unpacked kernel tree.

/lib/modules is probably the easiest place to get some agreement. The
contents of that directory is not specified as of FHS 2.1. 

This discussion should probably be done on the FHS list so that the
results can written up in that document. It currently mandates that
(for example) /usr/include/linux points at /usr/src/linux/include/linux.

-- 
                                            __O 
Fireplug - a Lineo company                _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>       www.fireplug.net        604-461-7532

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
