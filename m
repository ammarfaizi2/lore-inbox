Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUGSUFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUGSUFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 16:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265360AbUGSUFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 16:05:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19840 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265500AbUGSUEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 16:04:53 -0400
Date: Mon, 19 Jul 2004 16:04:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jason Gauthier <jgauthier@lastar.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 SMP trouble?
In-Reply-To: <2873B794CB1BE04F80E2968B438680E503ACF5C1@server6.ctg.com>
Message-ID: <Pine.LNX.4.53.0407191557590.3740@chaos>
References: <2873B794CB1BE04F80E2968B438680E503ACF5C1@server6.ctg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2004, Jason Gauthier wrote:

> I've found an IBM netfinity (5600) box that was shelved a few years ago.  I
> spent $80 and got two processors for it. (P3-667).
>
> I put them in the box, installed Linux (slackware) and upgraded the kernel
> to 2.6.7.  I then started installing my software on it.  Nagios, MRTG,
> samba, and some other tools we use for network monitoring.  This is going to
> be an upgrade to a monitoring server we have.  Well, I went home, came in
> the next day and the box was locked hard.  No messages, no console output.
> Just dead.
>
> Thinking it was a fluke, I fired it up.  Again, after several hours running;
> total death.  So, I figured I have two options.  Software or hardware is
> making it die.  I removed each processor in turn, and ran the box for over
> 24 hours under HIGH stress. (5+ load average). The system is running the
> above mentioned software.  But, just to make sure this processor gets a
> workout I am compiling code over and over.  Both processors have been rock
> solid for the duration of the test.
>
> I then placed both processors in the box and started the same test.  It was
> dead within 8 hours.  I am now very suspicious of the kernel.
>
> So, I installed 2.4.22 and ran the same tests.  It went over 48 hours with
> no issues.  Now I'm certain it's the kernel.  Can anyone confirm any SMP
> issues that might cause this?
>
> Thanks,
>
> Jason

Another data-point. I haven't been able to run any new (2.6+) kernel
reliably in a SMP machine. They stop. Just like you noted. That's
why all my SMP machines still run 2.4.26. It's rock solid and has
the latest-and-greatest updates (there's a -pre-27 coming out).
Anyway, for production machines, you probably need to run 2.4.26.

If you don't really need anything reliable, you might try to enable
Sys Req and see if you can find out where it's stopped. When my
machines stop, the CPUs get cold, just like their clocks were
shut off! -- another data-point --


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


