Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282818AbRLWR7W>; Sun, 23 Dec 2001 12:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282941AbRLWR7N>; Sun, 23 Dec 2001 12:59:13 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:42258 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S282818AbRLWR7C>; Sun, 23 Dec 2001 12:59:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sun, 23 Dec 2001 12:57:09 -0500
X-Mailer: KMail [version 1.3.2]
Cc: otto.wyss@bluewin.ch,
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org'),
        rusty@rustcorp.com.au (Rusty Russell)
In-Reply-To: <E16I8zQ-0000d9-00@the-village.bc.nu>
In-Reply-To: <E16I8zQ-0000d9-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ICrx-0000WN-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 December 2001 8:48, Alan Cox wrote:
>
> And vendors who've shipped GRUB still have to ship Lilo because Grub plain
> doesn't work on some machines. 

This is an issue with how GRUB deals with a FUBAR BIOS, and not 
necessarily a core GRUB design flaw. 

Syslinux, seems to win hands down (IMO) when it comes to dealing with
flacky BIOS's, but it's not because it's a dynamic loading design; it's
because HPA knew enough and spent the time refining that 1% of the
program that deals with bad BIOSes.

Should HPA and Werner take a day of their time to review and
correct GRUB, I'm sure this issue would vanish overnight.

> Lilo has the virtue that its extremely
> simple in what it does and how it does it. It works in a suprisingly large
> number of cases and can handle interesting setups that GRUB really
> struggles with.

Where GRUB struggles LILO throws up brickwalls.

Coolest thing is the world you can do with grub:
	Load a *partition* as your initrd
With this in mind it makes using images/archives for initrd for
non-embedded systems seem rather clunky. It's much cleaner
to just have an 8/16/32MB partition you dedicate to initrd. Users of
GRUB have been able to do this for YEARS.

And something to say here: Yes I hate lilo, but not because I think
Werner coded it lousy. A boot loader that uses a static block offset
to find it's target is a bad idea, that should have died with M$-DOS.

That said, it's still a wonder to me why GRUB, or another loader similar
in approach, was not adopted as the 'prefered' linux loader years ago. 

Dave

-- 
The time is now 22:54 (Totalitarian)  -  http://www.ccops.org/
