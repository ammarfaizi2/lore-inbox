Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbQKTQT2>; Mon, 20 Nov 2000 11:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQKTQTI>; Mon, 20 Nov 2000 11:19:08 -0500
Received: from wg.redhat.de ([193.103.254.4]:62825 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S129165AbQKTQTB>;
	Mon, 20 Nov 2000 11:19:01 -0500
Date: Mon, 20 Nov 2000 16:48:58 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@redhat.de>
To: "Charles Turner, Ph.D." <cturner@quark.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <Pine.LNX.3.95.1001120084920.580A-100000@quark.analogic.com>
Message-ID: <Pine.LNX.4.30.0011201639270.16038-100000@bochum.redhat.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong list, but this needs to be set straight. Please send any further
problem reports about Red Hat Linux to http://bugzilla.redhat.com/bugzilla

> I was terribly wrong. This Red Hat version is irrevocably defective.

With the exception that it works for everyone else.

> (1)	It will not create a bootable disk because it forgets
> 	to load scsi_mod.o, and sd_mod.o  before it loads
> 	aic7xxx.o

This doesn't happen here. It's supposed to use modprobe, which
automatically finds these dependencies.

> 	/etc/conf.modules was found to contain only aic7xxx
> 	as an alias for scsi_hostadapter.

How did you install that?
>From a relatively fresh 6.2 install (this box doesn't have any SCSI
controllers or soundcards):

# cat /etc/conf.modules
alias eth0 3c90x
alias parport_lowlevel parport_pc

> (3)	It "sort of" worked. However, network daemons kept
> 	dropping core. X would eventually crash, leaving the
> 	terminal in an unusable state, etc.

Are you sure the hardware is ok? Applications that usually work well
dumping core is usually a sign of bad memory or overheated CPUs. See
http://www.bitwizard.nl/sig11/ for more detailed information.

It's either this, or you've added customizations that don't work, or
you've used a CD someone has tampered with.

We know of _many_ servers running Red Hat Linux 6.2 with an uptime ever
since they first installed.

> (4)	It is impossible to build a known working kernel on the
> 	machine because the linker, `ld` crashes:

Same as (3).
I've been using 6.2 until 7 was released, I usually compile about 25
packages a day, and I've never seen ld crashing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
