Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVDES5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVDES5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVDES5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:57:19 -0400
Received: from web88009.mail.re2.yahoo.com ([206.190.37.196]:22165 "HELO
	web88009.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261892AbVDES4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:56:20 -0400
Message-ID: <20050405185620.80060.qmail@web88009.mail.re2.yahoo.com>
Date: Tue, 5 Apr 2005 14:56:20 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working o

--- Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > I've noticed something strange with issuing
> 'standby' to the system:
> > 
> > when echoing "standby" to /sys/power/state,
> nothing happens, not even a log or 
> > system activity to attempt standby mode.
> > 
> > However, trying echo "1" to /proc/acpi/sleep the
> system attempts to (standby) 
> > and aborts:
> > 
> > [4295945.236000] PM: Preparing system for suspend
> > [4295946.270000] Stopping tasks: 
> >
>
=============================================================================|
> > [4295946.370000] Restarting tasks... done
> > 
> > We get no reason as to why it quickly aborts. 
> 
> > [4294672.065000] ACPI: CPU0 (power states: C1[C1]
> C2[C2] C3[C3])
> > [4294676.827000] ACPI: (supports S0 S3 S4 S5)
> 
> 
> ...aha, but your system does not support S1 aka
> standby.
>  

Right, so nothing should happen if I try to do it, but
something does only in /proc/acpi/sleep does the
system attempt S1 which is not supported.

Do you know if /proc/acpi/sleep will be deprecated in
favour of /sys/power/state? If so, this thread will be
moot ;)

> > What is '1' in /proc/acpi/sleep?  standby mode is
> not the same as suspend to 
> > ram? when I put a normal desktop in standby mode
> its still 'on' but the hard 
> > disk is put to sleep and the system runs in a
> lower power mode. 
> 
> stanby != suspend to ram.

Correct, I wanted to be sure.

> 
> 				Pavel
> -- 
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51
> time=448769.1 ms         
> 
> 
