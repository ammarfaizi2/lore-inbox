Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263918AbRF3UhG>; Sat, 30 Jun 2001 16:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbRF3Ug4>; Sat, 30 Jun 2001 16:36:56 -0400
Received: from imladris.infradead.org ([194.205.184.45]:20751 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S263918AbRF3Ugg>;
	Sat, 30 Jun 2001 16:36:36 -0400
Date: Sat, 30 Jun 2001 21:36:26 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Adam J Richter <adam@yggdrasil.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6p6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
In-Reply-To: <20010630160101.G12788@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0106302120560.14977-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, Adam.

 >> So, I guess something like Keith Owens's patch would be the way
 >> to go, with some additional definitions (CONFIG_AGP, CONFIG_PCI,
 >> CONFIG_ISA, CONFIG_EISA, CONFIG_PCMCIA, and possibly others).
 >> I am not sure which other conditionals might also be incorrectly
 >> ignored by some instances of dep_xxx.  Below, I have included a
 >> list of the 52 CONFIG_* variables that are used as arguments to
 >> dep_xxx in 2.4.6-pre6 and appear in arch/*/config.in.

 > I have confirmed that Keith Owens patch doesn't work with
 > xconfig - you can't select any option which has been
 > define_bool'd to 'n'.

I've followed this thread with interest, and think I've followed both
sides of the argument, so can I summarise:

 1. Adam's point is that there are dep_* statements in the config
    setup that have been used to say that a particular option is
    dependant upon a particular architecture, but this doesn't work.

 2. Russell's point is that Adam's point is correct, but the patch
    that Adam submitted can't be used as it breaks other things.

 3. MY understanding of the situation is that ALL architecture
    specific config lines are EXPECTED to be in the arch/*/config.in
    files, where they will only even be seen when the relevant
    architecture is being compiled for.

As a result of this, I would summarise this discussion as saying that
there is a bug in the kernel config scripts in that some options that
should be located in the architecture-specific config files are in the
all-architecture config files instead.

Best wishes from Riley.

