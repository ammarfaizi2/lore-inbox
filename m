Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSI2Xsi>; Sun, 29 Sep 2002 19:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261843AbSI2Xsi>; Sun, 29 Sep 2002 19:48:38 -0400
Received: from dp.samba.org ([66.70.73.150]:57034 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261842AbSI2Xsh>;
	Sun, 29 Sep 2002 19:48:37 -0400
Date: Mon, 30 Sep 2002 09:51:41 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20020929235141.GA1090@krispykreme>
References: <20020929152731.GA10631@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929152731.GA10631@averell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andi,

> Also added an noinline macro to wrap __attribute__((noinline)). That's 
> not used yet. It tells the compiler that it should never inline, which
> may be useful to prevent some awful code generation for those misguided
> folks who use -O3 (gcc often screws up the register allocation of a 
> function completely when bigger functions are inlined). 

Could you also add an always inline? It would be useful for functions
like context_switch, where we require it to be inlined (otherwise it
falls outside scheduling_functions_{start,end}_here and wchan handling
fails).

Anton
