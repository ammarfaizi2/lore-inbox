Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317547AbSG2RlF>; Mon, 29 Jul 2002 13:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317543AbSG2RlF>; Mon, 29 Jul 2002 13:41:05 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:18564
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317547AbSG2RkZ>; Mon, 29 Jul 2002 13:40:25 -0400
Date: Mon, 29 Jul 2002 10:43:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Message-ID: <20020729174341.GA12964@opus.bloom.county>
References: <20020729181702.E25451@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729181702.E25451@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 06:17:02PM +0100, Russell King wrote:

 
> 1. Serial port initialisation
> -----------------------------
> 
> Firstly, one thing to bear in mind here is that, as Alan says "be nice
> to make sure it was much earlier".  I guess Alan's right, so we can get
> oopsen out of the the kernel relatively easily, even when we're using
> framebuffer consoles.
> 
> I'm sure Alan will enlighten us with his specific reasons if required.
> 
> There have been several suggestions around on how to fix this table:
> 
> a. architectures provide a sub-module to 8250.c which contains the
>    per-port details, rather than a table in serial.h.  This would
>    ideally mean removing serial.h completely.  The relevant object
>    would be linked into 8250.c when 8250.c is built as a module.

I think this would work best.  On PPC this would allow us to change the
mess of include/asm-ppc/serial.h into a slightly cleaner Makefile
(especially if we do the automagic <platforms/platform.h> or
<asm/platform.h> bit that's been talked about in the past) magic and we
could use that object file as well in the bootwrapper as well.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
