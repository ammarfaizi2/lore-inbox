Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266968AbUBEWLF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266954AbUBEWLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:11:04 -0500
Received: from cathy.bmts.com ([216.183.128.202]:6554 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S266968AbUBEWKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:10:37 -0500
Date: Thu, 5 Feb 2004 17:10:27 -0500
From: Mike Houston <mikeserv@bmts.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Message-Id: <20040205171028.652a694c.mikeserv@bmts.com>
In-Reply-To: <20040205203840.GA13114@ucw.cz>
References: <200402041820.39742.wnelsonjr@comcast.net>
	<200402051517.37466.murilo_pontes@yahoo.com.br>
	<20040205203840.GA13114@ucw.cz>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004 21:38:40 +0100
Vojtech Pavlik <vojtech@suse.cz> wrote:

> Hey, guys, could you possibly try to figure out what your machines have
> in common? I've switched all my computers to PS/2 mice so that I have a
> bigger chance to reproduce the problem, but it is not happening on any
> of them.

Hello Vojtech and everyone following this thread.

The problem is quite intermittent, it hasn't happened to me yet today. (machine has been up about 6 hours). The problem has never happened to me, with 2.6.1 or any previous kernel.

I'm not sure that it's load related, each time it has seemed to happen to me, while in a menu somewhere. (not specific apps either, and it has happened both in KDE and XFCE)

In trying to nail down something in common, I'll start with XFree86.

XFree86 Version 4.3.99.902 (4.4.0 RC 2)
Release Date: 18 December 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.0 i686 [ELF] 
Current Operating System: Linux getstuffed 2.6.2 #1 Wed Feb 4 12:11:41 EST 2004 i686
Build Date: 21 December 2003
Changelog Date: 19 December 2003

Kernel headers were mentioned by Murilo in the previous email. On my Slackware system, I have /usr/include/linux and asm as links pointing to the appropriate places in the 2.4.23 source tree. (I compiled Glibc 2.3.2 with these in place)

I posted my 2.6.2 config and dmesg in a previous email, so I won't bore the list again with it. I put them up on my personal web space though, in case anyone wants to look at them.

http://www.bitbenderforums.com/~grogan/files/config-2.6.2.txt
http://www.bitbenderforums.com/~grogan/files/dmesg.txt

This is a pentium4 system. i845 chipset (Gigabyte board). Logitech MX500 optical wheel mouse (not cordless), using the usb to ps/2 adapter that came with it. Radeon 7500 AGP video card.

I am using ACPI and IO-APIC. Next time my mouse acts up, I will consider trying 2.6.2 without ACPI and IO-APIC (though I'd hate to lose that functionality). Trouble is it might take a long time for the mouse glitch to occur.

That's about all I can think of for now, holler if you wish to ask something more.

I am also willing to try any patches or configuration options to help track this down. I'll tell you right now, I'm not much of a coder but if I'm told what to do, I can do it.

Thanks,
Mike Houston (a.k.a. Grogan)
