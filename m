Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311701AbSEEMrQ>; Sun, 5 May 2002 08:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311829AbSEEMrP>; Sun, 5 May 2002 08:47:15 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:53515 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S311701AbSEEMrO>; Sun, 5 May 2002 08:47:14 -0400
Date: Sun, 5 May 2002 14:47:04 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "J.P. Morris" <jpm@it-he.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.x keyboard oddities
Message-ID: <20020505124704.GC4990@louise.pinerecords.com>
In-Reply-To: <20020504234908.39e71442.jpm@it-he.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 13 days, 2:27)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [J.P. Morris <jpm@it-he.org>]
> The other day I finally got a 2.5 kernel (2.5.13) to compile and boot.
> One of the major stumbling (crashing) blocks seems to be DEVFS, so I
> simply disabled it and booted the kernel.
> 
> The system appears to have come up completely now, except for the
> keyboard which is totally frozen throughout the entire boot process.
> 
> I don't have another PC but I might try and get my Psion Series 5
> to act as a VT100 terminal and go in through serial.
> 
> The keyboard is a bog-standard AT 102 keyboard, attached through a
> AT/PS2 converter to an ABIT KT133 ATX motherboard.. no USB stuff.
> Keyboard is turned on in the input devices option in kernel config.
> But it's utterly dead: even ALT-SYSRQ-B.  Is this normal?

1) Try booting with 'acpi=off'. It's broken for a number of systems
(does precisely what you've described) and no official update is
available as of yet. Alternatively, you can try to apply the most
recent ACPI patch from [1].

2) Make sure you've enabled core input support and userland keyboard
interface (CONFIG_INPUT, CONFIG_INPUT_KEYBDEV).

T.


[1] http://www.sourceforge.net/projects/acpi/
