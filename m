Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSAZQiZ>; Sat, 26 Jan 2002 11:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbSAZQiP>; Sat, 26 Jan 2002 11:38:15 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:32391 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S285352AbSAZQiC>; Sat, 26 Jan 2002 11:38:02 -0500
Message-ID: <012d01c1a687$faa11120$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Jamie Lokier" <lk@tantalophile.demon.co.uk>,
        "Linus Torvalds" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de> <200201250802.32508.bodnar42@phalynx.dhs.org> <jeelkes8y5.fsf@sykes.suse.de> <a2sv2s$ge3$1@penguin.transmeta.com> <20020126034106.F5730@kushida.apsleyroad.org>
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Date: Sat, 26 Jan 2002 17:39:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Jamie Lokier" <lk@tantalophile.demon.co.uk>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, January 26, 2002 4:41 AM
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel


> Linus Torvalds wrote:
> > It's sad that gcc relegates "optimize for size" to a second-class
> > citizen.  Instead of having a "-Os" (that optimizes for size and doesn't
> > work together with other optimizations), it would be better to have a
> > "-Olargecode", which explicitly enables "don't care about code size" for
> > those (few) applications where it makes sense.
>
> Btw, there have been suggestions that -Os may actually be faster for x86
> code on current processors.

Hmm.. I tried to compile the kernel with -Os (gcc 2.96-98) and I just got a
~1% smaller vmlinux and a ~3% smaller bzImage. Maybe the size optimizations
doesn't show on these files? Internal data structures that are much bigger
than "real" code?

This is how I did:
--- Makefile    Sat Jan 26 17:15:52 2002
+++ Makefile.Os Sat Jan 26 17:15:30 2002
@@ -88,7 +88,7 @@

 CPPFLAGS := -D__KERNEL__ -I$(HPATH)

-CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -Os \
          -fomit-frame-pointer -fno-strict-aliasing -fno-common
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)

 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden

- ABIT BP6(RU) - 2xCeleron 400 - 128MB/PC100/C2 Acer
- Maxtor 10/5400/U33 HPT P/M - Seagate 6/5400/DMA2 HPT S/M
- 2xDE-530TX - 1xTulip - Linux 2.4.17+ide+preempt

