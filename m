Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315808AbSE3AYR>; Wed, 29 May 2002 20:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315922AbSE3AYQ>; Wed, 29 May 2002 20:24:16 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:57593 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315808AbSE3AYQ>; Wed, 29 May 2002 20:24:16 -0400
Subject: Re: [RFC] [PATCH] Disable TSCs on CONFIG_MULTIQUAD
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022712736.9255.289.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 May 2002 17:20:54 -0700
Message-Id: <1022718054.1963.51.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Add CONFIG_X86_TSC_NOT_SYNCHRONOUS or similar and then check
> 
> #if defined(CONFIG_X86_TSC) && !defined(CONFIG_X86_NOT_SYNCHRONOUS))

<laugh> I guess I asked for it. :) I actually implemented something
similar to the above earlier, and was convinced out of it. The trade off
with this method is that while it simplifies the config.in changes, it
complicates the 12 or so #ifdef CONFIG_X86_TSC lines. 

Keeping the "multi-quad TSCs are broken" fact in just one place
(config.in), rather then spread about the tree in precompiler
statements, seems like the best choice to me. I was actually hoping
there was a good config.in trick for turning CONFIG_X86_TSC off after it
had already been turned on, rather then adding a meta-option, but I'm
guessing there isn't.

Anyway, if you really would rather see what you suggested, I'll happily
change it (I do like the idea of breaking the CONFIG_X86_TSC_UNSYNCED
notion out of CONFIG_MULTIQUAD).

Thanks for the feedback!
-john

