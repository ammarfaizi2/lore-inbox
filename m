Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275354AbTHGOj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275353AbTHGOj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:39:28 -0400
Received: from web40603.mail.yahoo.com ([66.218.78.140]:5151 "HELO
	web40603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S275355AbTHGOic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:38:32 -0400
Message-ID: <20030807143831.73389.qmail@web40603.mail.yahoo.com>
Date: Thu, 7 Aug 2003 15:38:31 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Loading Pentium III microcode under Linux - catch 22!
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tigran@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1060264715.3169.51.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> As far as I am aware none of the microcode updates
> even apply to 933Mhz era PIII, just the ones the
> BIOS ships with by default nowdays. Also the kind of
> stuff the errata fix are obscure ultra-weird corner
> cases people just don't hit.

Lucky me, eh?

My CPUs *do* take microcode, and they are 933 MHz...
;-). I upgraded from a pair of 733 MHz CPUs bought in
July 2000, and my current BIOS just doesn't have any
microcode for them. Without the update, I used to come
back at the end of the day, switch on the KVM and be
unable to use the keyboard and mouse.

Anyway, I wasn't aware that Intel had released a
changelist for their microcode updates. Goodness knows
what bugs they're fixing.

> Thus I'd be very suprised if loading the microcode
> any earlier was neccessary - certainly nobody else
> has reported needing to.

My machine is currently hanging during boot-up (while
fscking the root partition, or releasing the "init"
memory), and CPU malfunction is the leading candidate
explanation. I have already replaced the 300W PSU with
a 400W one and tested the memory.

> > In an ideal world, I would like Linux to load the
> > microcode *before* the kernel boots, which begs
> > the question of "How?". Can you suggest anything,
> > please?
> 
> The kernel can't load the microcode until it has
> booted,

Yes, that's the "catch-22" bit. I was originally
thinking about either a bootstrapping floppy disk, or
maybe hacking some code into the boot-up sequence
itself.

> it can load it very early after that from initrd.

OK, I'll look into that.

Cheers,
Chris



________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://uk.messenger.yahoo.com/
