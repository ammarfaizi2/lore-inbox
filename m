Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUHaFF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUHaFF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 01:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUHaFFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 01:05:54 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:3852 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266585AbUHaFFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 01:05:42 -0400
Date: Tue, 31 Aug 2004 07:05:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ryan Cumming <ryan@spitfire.gotdns.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Message-ID: <20040831050519.GE564@alpha.home.local>
References: <412B5B35.7020701@apartia.fr> <20040825044551.GH1456@alpha.home.local> <20040824233648.53eb7c30.davem@redhat.com> <200408301814.41346.ryan@spitfire.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408301814.41346.ryan@spitfire.gotdns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 06:14:38PM -0700, Ryan Cumming wrote:
> On Tuesday 24 August 2004 23:36, you wrote:
> > I pity the poor fool who wishes to netboot his system using
> > a tg3 card and use an nfsroot with Debian.  Kind of hard to
> > get the card firmware from the filesystem in that case.
> initramfs?
> 
> > The tg3 firmware is just a bunch of MIPS instructions.
> > I guess if I ran objdump --disassemble on the image and
> > used the output of that in the tg3 driver and "compiled
> > that source" they'd be happy.  And this makes the situation
> > even more ludicrious.
> For GPL compliance, no, that wouldn't work. The GPL states:
> "The source code for a work means the preferred form of the work for making 
> modifications to it."
> 
> Which is likely C or at least assembly with label names and comments in this 
> case.

It would have taken less time for the people who removed the firmware and
will assure support for their users to disassemble this code and put labels
and comments in it. When I was 16, I totally disassembled my PC's bios (8kB)
commented it and labelled it to the point of making it re-assemblable. It
did not take very much time (a week-end), and it was crappy x86 code with
unaligned and mangled code/data + hard-coded stack values for the "calls"
without any RAM usage. Here you have about 2kB of clean MIPS code which is
about 500 instructions (500 lines). I doubt anyone knowing mips assembly
enough would spend more than a week-end putting comments and labels in it.

Now another possibility would be for those zealots to replace the firmware
by an open-source one such as http://alteon.shareable.org/ which BTW contains
all the tools needed for the dirty work.

Anyway, this thread is getting boring...

Regards,
Willy

