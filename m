Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318377AbSGRXER>; Thu, 18 Jul 2002 19:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318386AbSGRXER>; Thu, 18 Jul 2002 19:04:17 -0400
Received: from www.transvirtual.com ([206.14.214.140]:13580 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318377AbSGRXER>; Thu, 18 Jul 2002 19:04:17 -0400
Date: Thu, 18 Jul 2002 16:07:06 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Andi Kleen <ak@suse.de>
cc: Matthew Wilcox <willy@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.26 broken on headless boxes
In-Reply-To: <p73adopurv4.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0207181604140.16453-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I also see similar problems on x86-64 in 2.5.25.  The kernel quickly crashes
> when trying to return from opost_write() because something below has zeroed
> out the stack (with serial console and vga console and early console enabled)
> I have not tried it with 2.5.26 yet.

It is the result of registering the console device first for printk and
then later registering the tty device. Eventually I like to be able to
have VT_CONSOLE independent of CONFIG_VT so we could have a light weight
printk. The goal is register tty device once we find a keyboard of some
kind.

