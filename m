Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbRDBWoU>; Mon, 2 Apr 2001 18:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbRDBWoL>; Mon, 2 Apr 2001 18:44:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34065 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131424AbRDBWnz>; Mon, 2 Apr 2001 18:43:55 -0400
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
To: jsimmons@linux-fbdev.org (James Simmons)
Date: Mon, 2 Apr 2001 23:44:37 +0100 (BST)
Cc: lk@tantalophile.demon.co.uk (Jamie Lokier),
   linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
   linux-fbdev-devel@lists.sourceforge.net (Linux Fbdev development list)
In-Reply-To: <Pine.LNX.4.31.0103301959010.743-100000@linux.local> from "James Simmons" at Mar 30, 2001 08:11:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kD3w-0006qD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes this is problem. See my response to Paul about this. The only reason
> I'm using MMX for the vesa framebuffer because it has no acceleration. MMX
> gives a big boost for genuine intel chips. Other types of MMX are fast but
> they don't seemed to be optimized for memory transfers like MMX on intel
> chips. I also have regular code that does all kinds of tricks to optimize

Then you are doing something badly wrong.

The MMX memcpy for CyrixIII and Athlon boxes is something like twice the
speed of rep movs. On most pentium II/III boxes the fast paths for rep movs
and for MMX are the same speed

Alan

