Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267293AbUGNGmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267293AbUGNGmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 02:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUGNGmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 02:42:53 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:44221 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S267293AbUGNGmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 02:42:51 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Pavel Machek <pavel@suse.cz>
Date: Wed, 14 Jul 2004 08:24:56 +0200
MIME-Version: 1.0
Subject: Re: Murphy hits (Kernel 2.6, ext2, "check=strict"): corrupted filesystem
CC: linux-kernel@vger.kernel.org
Message-ID: <40F4EDDB.9276.213C3F@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <20040713204833.GI3654@openzaurus.ucw.cz>
References: <40F251F1.1057.35E0C3@rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.21a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.80+2.19+2.07.060+05 April 2004+90341@20040714.061942Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jul 2004 at 22:48, Pavel Machek wrote:

> Hi!
> 
> > I'd like to present a little story how to shredder your ext2 filesystem:
> > 
> > I was installing SuSE Linux 9.1 when the kernel froze rather late during 
> > installation. So I had to reset the PC. There is a minor bug in the forementioned 
> 
> You call this "minor"?

...in the eyes of real-life (Linux distributor's) software support it is. Not in 
mine.

> 
> > Why I'm writing this: If something can go wrong, eventually it will. For a true 
> > disaster you always need more than just one problem (1: Kernel freeze, 2: no fsck 
> > being run, 3: kernel happily mounts unclean filesystem for read-write).
> 
> 3 is feature. It prints warning, but lets you mount it. I sometimes mount
> broken fs's rw; it actually saved me once when I was hitting fsck bug.
> It is also handy when quickly recovering scratch machine.
> 
> MS-DOS had no fsck... and survive. ext2 can survive with similar results
> if you just dont fsck...

The syslog was full with attempts to access the device outside its limits. Seems 
there was some  bad constellation after the kernel crash.

> 
> > I think nobody really wants to read reports where Linux has shreddered a 
> > filesystem, do we?
> 
> I actually liked your report ;-).

(after two days of work and reinstalling about 90% of the RPMs I have a working 
system again. The other stupid thing that doesn't belong to this list is: RPM v4 
fails to install a package if one of the packet's file targets exists as a 
directory (happened after the crash and fsck to me). RPM then seems unable to 
cleanup and leaves aditional files with a semicolon and hexadecimal number as 
suffix then. Repeated invocations create new files then...)

Regards,
Ulrich
(& thanks for replying)


