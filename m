Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbUKUUbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUKUUbG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 15:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUKUU3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 15:29:49 -0500
Received: from news.suse.de ([195.135.220.2]:31128 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261789AbUKUU3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 15:29:34 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Adam Belay <ambx1@neo.rr.com>, Thomas Hood <jdthood@mail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: What exactly is __ALIGN_STR in pnpbios/bioscalls.c for?
References: <20041121175659.GD2924@stusta.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!  Now I get to think about all the BAD THINGS I did to a BOWLING
 BALL
 when I was in JUNIOR HIGH SCHOOL!
Date: Sun, 21 Nov 2004 21:29:32 +0100
In-Reply-To: <20041121175659.GD2924@stusta.de> (Adrian Bunk's message of
 "Sun, 21 Nov 2004 18:56:59 +0100")
Message-ID: <jefz337xoz.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> include/linux/linkage.h in kernel 2.6 includes #define's for __ALIGN and 
> __ALIGN_STR. In include/asm-i386/linkage.h, their values are changed 
> #ifdef CONFIG_X86_ALIGNMENT_16.
>
> It isn't obvious what exacly CONFIG_X86_ALIGNMENT_16 is for (I've heard 
> more than one opinion), and since the __ALIGN_STR usage in 
> drivers/pnp/pnpbios/bioscalls.c is the only non-m68k usage of one of 
> these two #define's I wonder whether you might be able to enlighten me 
> what CONFIG_X86_ALIGNMENT_16 exactly is for?

It's for aligning function entries to a 16 byte boundary instead of only 4
bytes, used together with -malign-functions.  See also the ENTRY macro.
Note that the default value of __ALIGN is actually useless for anything
but x86 and x86-64.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
