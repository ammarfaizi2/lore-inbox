Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271398AbTG2LEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271399AbTG2LEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:04:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:29320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271398AbTG2LEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:04:43 -0400
Date: Tue, 29 Jul 2003 07:06:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Charles Lepple <clepple@ghz.cc>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
In-Reply-To: <21265.216.12.38.216.1059425148.squirrel@www.ghz.cc>
Message-ID: <Pine.LNX.4.53.0307290702150.30141@chaos>
References: <Pine.LNX.4.53.0307281555400.27569@chaos>    <1059422724VQM.fvw@tracks.var.cx>
    <Pine.LNX.4.53.0307281619060.27642@chaos> <21265.216.12.38.216.1059425148.squirrel@www.ghz.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Charles Lepple wrote:

> Richard B. Johnson said:
> <snip>
> > It is impossible to send escape sequences to an input that does
> > not exist. That's why I need to know how to stop the kernel's
> > insistence on turning off the screen.
>
> from 'strace setterm -blank 0':
>
>    write(1, "\33[9;0]", 6)                 = 6
>
> which means you want to write the escape sequence to standard output (fd
> 1), or /dev/tty0 if your code is not attached to the current console. This
> should be independent of any input devices that may or may not be there.
>
> --
> Charles Lepple <ghz.cc!clepple>
> http://www.ghz.cc/charles/

Yes. This is f*ing absurb. A default that kills the screen and the
requirement to send some @!_$%!@$ sequences to turn it off. This
is absolute crap, absolutely positively, with no possible justification
whatsoever. If I made an ioctl, it will probably be rejected.........

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

