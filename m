Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280163AbRKIVn1>; Fri, 9 Nov 2001 16:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280186AbRKIVnW>; Fri, 9 Nov 2001 16:43:22 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:1033 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S280163AbRKIVnF>;
	Fri, 9 Nov 2001 16:43:05 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Rick Gaudette <Richard.Gaudette@Colorado.EDU>
Date: Fri, 9 Nov 2001 22:42:43 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: X-Windows locks up under concurrent OpenGL (Mesa) and I
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <8B83CB50455@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Nov 01 at 14:11, Rick Gaudette wrote:

> within a couple of hours.  We can usually ssh into the hung machine from
> another machine and kill the application to bring back X.  Top shows

Happy you.

> CPUs:

Dual PIII / 800MHz.
 
> Motherboards:

Gigabyte GA-6VXD7 (with VIA694X)

> Video cards:

G450 with XF 4.1.0 drivers.

> OS Versions:

Debian.

> Typical system config:

45GB IDE
256MB RAM

> A simple way to do persistent concurrent I/O:

Watching fbtv on second G450 head. It stresses AGP as it generates
30MBps stream from PCI -> AGP...

> Any help with this problem would be greatly appreciated.

... and machine is dead - poweroff button does not work. I always thought
that it is specific to VIA chipsets, as almost same configuration (PII
instead of PIII) worked fine on GA-6BXDS (i440BX), and it is new to me
that AMD has same troubles. Help is simple - do not use VIA chipsets,
at least I did not found any other way how to get it to work
(except disabling mainmemory,PCI->AGP transfers (CPU->AGP are OK, 
obviously...)).
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
P.S.: If you have dualhead G400 on VIA and two bt848 grabbers, just run
one fbtv -k on first head, and another fbtv -k on second head. It will
die as soon as you hit enter on second fbtv (and of course they must be
in <=16bpp, as 694X does not handle even one memory stream needed for 
32bpp full PAL PCI->AGP transfer).
                                                
