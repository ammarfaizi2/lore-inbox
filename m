Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSI3A0X>; Sun, 29 Sep 2002 20:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261870AbSI3A0X>; Sun, 29 Sep 2002 20:26:23 -0400
Received: from zero.aec.at ([193.170.194.10]:15626 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261860AbSI3A0I>;
	Sun, 29 Sep 2002 20:26:08 -0400
Date: Mon, 30 Sep 2002 02:31:21 +0200
From: Andi Kleen <ak@muc.de>
To: Anton Blanchard <anton@samba.org>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20020930003121.GB2805@averell>
References: <20020929152731.GA10631@averell> <20020929235141.GA1090@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929235141.GA1090@krispykreme>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 01:51:41AM +0200, Anton Blanchard wrote:
> 
> Hi Andi,
> 
> > Also added an noinline macro to wrap __attribute__((noinline)). That's 
> > not used yet. It tells the compiler that it should never inline, which
> > may be useful to prevent some awful code generation for those misguided
> > folks who use -O3 (gcc often screws up the register allocation of a 
> > function completely when bigger functions are inlined). 
> 
> Could you also add an always inline? It would be useful for functions
> like context_switch, where we require it to be inlined (otherwise it
> falls outside scheduling_functions_{start,end}_here and wchan handling
> fails).

Ok. gcc supports it with __attribute__((always_inline))

Suggestions for a name? alwaysinline would be a bit lengthy.

-Andi
