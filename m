Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTDKRZy (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTDKRZv (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:25:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14984 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261296AbTDKRZp (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 13:25:45 -0400
Date: Fri, 11 Apr 2003 13:38:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: kernel support for non-English user messages
In-Reply-To: <200304111259_MC3-1-3405-E080@compuserve.com>
Message-ID: <Pine.LNX.4.53.0304111314340.9036@chaos>
References: <200304111259_MC3-1-3405-E080@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003, Chuck Ebbert wrote:

> Alan Cox wrote:
>
>
> > You are right about needing to log parameters, but given a log line
> > of the form
> >
> > %s: went up in flames\n\0eth0\0\0
> >
> > that can be handled by the log viewer
>
>
>   I still see some problems...
>
>   For one, there are 131 instances of:
>
>       printk("%s\n", blurb);

[SNIPPED....]

There are 48,038 printk statements in linux-2.4.20. The text portion
of those statements comprises 307,136 bytes, excluding modules!

This print-your-way code has more ASCII than MBASIC. It is
patently absurd and some people are trying to legitimize this
text bloat with a translation utility. Fork the kernel and
make it text-based if you want, but we need to remove most of
this text on the standard kernel, not make it somehow seem
right. It is wrong, just plain wrong, and it's getting worse
as time goes on.

Every one of those printk-drivers should have an ioctl() so
that some user-mode program can check on its health, how many
SCSI disks got found, what the Ethernet parameters are, etc.
This is not something that should be printed on the screen
every time the machine boots for the one-time-out-of-1000
that a disk didn't come on-line or the network didn't come
up. Most all of the error reporting within the kernel is being
done without regard to what used to be called "good standards
of engineering practice".

BSD also has this problem but you would expect that from
students because they become amazed as their driver starts
to work and they proudly print every intermediate step in
the initialization. Professionals should know better and
do better work.

Properly running software is indistinguishable from magic
and it is completely invisible to the user.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

