Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275720AbRI0AaM>; Wed, 26 Sep 2001 20:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275712AbRI0AaC>; Wed, 26 Sep 2001 20:30:02 -0400
Received: from host-029.nbc.netcom.ca ([216.123.146.29]:59910 "EHLO
	mars.infowave.com") by vger.kernel.org with ESMTP
	id <S275720AbRI0A3r>; Wed, 26 Sep 2001 20:29:47 -0400
Message-ID: <6B90F0170040D41192B100508BD68CA1015A81A7@earth.infowave.com>
From: Alex Cruise <acruise@infowave.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: apm suspend broken in 2.4.10
Date: Wed, 26 Sep 2001 17:29:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mine displays a similar failure, except my strace shows:

  ioctl(3, APM_IOC_SUSPEND, 0 ) = -1 EAGAIN (Resource temporarily
unavailable)

I also noticed (as reported by a previous poster) that whether you pass
"apm=on" or "apm=off" to the kernel, apm gets disabled.  When you don't
specify a setting, it's enabled.  I had a look at the arch/i386/kernel/apm.c
in 2.4.10 though, and it seemed to make sense.

--
Alex Cruise - Programmer, Iconoclast, Opinionated Bastard.
GCS/P v3.1a: d- s+:+ C++++$ UF++ UL++ P--- L++ E++ W++ N+ K w-- O- M 
PS++ PE- Y+ PGP-- t+@ 5- X-- R !tv b++ DI++ D++ G e* h--- r+++ y+++ 
