Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSK1NUO>; Thu, 28 Nov 2002 08:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSK1NUO>; Thu, 28 Nov 2002 08:20:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:269 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265480AbSK1NUN>; Thu, 28 Nov 2002 08:20:13 -0500
Date: Thu, 28 Nov 2002 08:26:16 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@redhat.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc4-ac1 SiS IDE driver troubles
In-Reply-To: <r1_200211271152.gARBqXI09379@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1021128082420.9795C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Alan Cox wrote:

> > After booting and initscripts I get some kind of error like a BUG() but
> > I can't see what it is because it scrolls off with repeated "unable to
> > handle kernel paging request" messages. The first error shows a stack trace
> > (briefly) but all the rest just show the offsets without the text.
> 
> Stick a while(1); at the end of the stack dump code and you should get
> jus tthe first oops you can read

You may want to block interrupts as well, I've used this trick (given by
akpm) before, and sometimes whatever is wrong will generate a double panic
on interrupt shortly after the first OOPS output.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

