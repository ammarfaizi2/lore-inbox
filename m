Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTEOPRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbTEOPRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:17:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42882 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264077AbTEOPRU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:17:20 -0400
Date: Thu, 15 May 2003 11:31:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Ricker <kaboom@gatech.edu>
cc: Jesse Pollard <jesse@cats-chateau.net>,
       Mike Touloumtzis <miket@bluemug.com>, Ahmed Masud <masud@googgun.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <Pine.LNX.4.55.0305150913471.6447@verdande.oobleck.net>
Message-ID: <Pine.LNX.4.53.0305151121420.19950@chaos>
References: <20030514074403.GA18152@bluemug.com> <20030514205847.GA18514@bluemug.com>
 <Pine.LNX.4.53.0305141724220.12328@chaos> <03051508174100.25285@tabby>
 <Pine.LNX.4.55.0305150913471.6447@verdande.oobleck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Chris Ricker wrote:

> On Thu, 15 May 2003, Jesse Pollard wrote:
>
> > On Wednesday 14 May 2003 16:32, Richard B. Johnson wrote:
> > > Not so, with the latest Red Hat distribution (9). You can no longer
> > > set init=/bin/bash at the boot prompt.... well you can set it, but
> > > then you get an error about killing init. This caused a neighbor
> > > a lot of trouble when she accidentally put a blank line in the
> > > top of /etc/passwd. Nobody could log-in. I promised to show her
> > > how to "break in", but I wasn't able to. I had to take her hard-disk
> > > to my house, mount it, and fix the password file. All these "attempts"
> > > at so-called security do is make customers pissed.
> >
> > I fix those errors with by booting the Slackware CD with the live
> > filesystem...
> >
> > No dependancies on any of the regular disks - then I can fix anything within
> > reason (haven't tried md raids though).
>
> You don't have to do that. Richard is mis-informed. Any of the following
> still work on Red Hat Linux 9:
>
> init=/bin/bash         # drops you straight to a bash shell
> init 1                 # runs runlevel 1 SysV init scripts and rc.sysinit
> init single            # runs rc.sysinit, but not runlevel 1
> init emergency         # runs a shell
>
> all without going to rescue media.
>

Bullshit. Try it. So called Linux 9 /Professional did **NOT** allow
anybody to break in. Maybe you didn't try it, or maybe it wasn't
tested in a machine that uses initrd to make the hard disk accessible,
but it absolutely positively fails to run any 'init' when the LILO boot
is interrupted and we entered, in addition to the linux OS label, the
parameter init=/bin/bash. We even tried, probably nearly a hundred
boots, over two days various things like init=/bin/csh.... various
possible shells, plus init=/sbin/init 1, etc. Any time 'init' was
defined on the boot command-line, the machine would panic with
'attempting to kill init'.

Also, when booting on the distribution media, the ALF-F2...F5  keys
no longer function so you can't access a shell. Try it before you
claim I'm "mis-informed". I wasted an entire weekend until I took
the damn hard disk out, brought it home, and "fixed" it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

