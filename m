Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267656AbTCFBCa>; Wed, 5 Mar 2003 20:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTCFBCa>; Wed, 5 Mar 2003 20:02:30 -0500
Received: from www.missl.cs.umd.edu ([128.8.126.38]:57106 "EHLO
	www.missl.cs.umd.edu") by vger.kernel.org with ESMTP
	id <S267656AbTCFBC3>; Wed, 5 Mar 2003 20:02:29 -0500
Date: Wed, 5 Mar 2003 20:35:52 -0500 (EST)
From: Adam Sulmicki <adam@cfar.umd.edu>
X-X-Sender: adam@www.missl.cs.umd.edu
To: Andy Pfiffer <andyp@osdl.org>
cc: Ro0tSiEgE LKML <lkml@ro0tsiege.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Boot Speedup
In-Reply-To: <1046911465.29868.46.camel@andyp.pdx.osdl.net>
Message-ID: <20030305203206.E14397-100000@www.missl.cs.umd.edu>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you want cold-start boot on a PC, you'll probably need to completely
> skip the BIOS (have a look at LinuxBIOS and/or kexec), skip the probing
> of devices on reboot, and drastically shorten (or run later) any
> user-mode scripts that are invoked.
>
> On the machines that I have measured (p3-800 and p4-1.7Xeon, a
> well-configured kernel, after subtracting out BIOS time and stupid scsi
> reprobing, is up and open for business in about 10 seconds after the
> LILO handoff.  The *system* however, isn't often available for another
> 30 or 40 seconds, perhaps longer.

Also, when you are using LinuxBIOS then time for the hard disk to spin up
actually becomes significant. And it is of order of several seconds (and
up to 30 seconds according to specs for ATA). To counter this problem you
may want to put kernel and root stuff on Compact Flash and then use
CF<->IDE adapter to use CF as primary boot device. (As side benefit it
allows you to easily get around 256KiB limitation of most eerpom (bios)
sockets on your typical motherboard)

-- 
Adam Sulmicki
http://www.eax.com 	The Supreme Headquarters of the 32 bit registers

