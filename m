Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317193AbSFRAYx>; Mon, 17 Jun 2002 20:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSFRAYw>; Mon, 17 Jun 2002 20:24:52 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:29416 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317193AbSFRAYv>; Mon, 17 Jun 2002 20:24:51 -0400
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binary compatibity (mixing different gcc versions) in modules
References: <7w3cvmdquu.fsf@avalon.france.sdesigns.com>
From: Andi Kleen <ak@muc.de>
Date: 18 Jun 2002 02:24:27 +0200
In-Reply-To: Emmanuel Michon's message of "Mon, 17 Jun 2002 14:40:07 +0200"
Message-ID: <m3sn3ljux0.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Michon <emmanuel_michon@realmagic.fr> writes:

> Hi,
> 
> looking at nvidia proprietary driver, the makefile warns
> the user against insmod'ing a module compiled with a gcc
> version different from the one that was used to compile
> the kernel.
> 
> This sounds strange to me, since I never encountered this
> problem.

Some earlier obsolete gcc versions had problems with empty types. This lead
to an #if based on the compiler version that added a dummy field
to spinlocks even for UP kernels. This made structure offsets of
structures with spinlocks change based on gcc version.

Should be long gone with recent compilers.

Still there are enough other variables to structure offsets depending 
on the configuration.

-Andi
