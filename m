Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSHAPVv>; Thu, 1 Aug 2002 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHAPVv>; Thu, 1 Aug 2002 11:21:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7693 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S315414AbSHAPVu>;
	Thu, 1 Aug 2002 11:21:50 -0400
Date: Thu, 1 Aug 2002 17:24:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PANIC] APM bug with -rc4 and -rc5
Message-ID: <20020801152459.GA19989@alpha.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> <20020801121205.GA168@pcw.home.local> <20020801133202.GA200@pcw.home.local> <1028213732.14865.50.camel@irongate.swansea.linux.org.uk> <20020801135623.GA19879@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020801135623.GA19879@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, thanks. I'll try to revert some patches from -rc4. But it looks
> more like a side effect IMHO. Perhaps the APM initialization code
> triggers one of the numerous bugs in the bios :-/

It seems that I cannot reproduce it anymore if I revert arch/i386/kernel/vm86.c
to the state of -rc3. Reverting clear_AC doesn't change anything, but the
rest of the patch does. I don't know why, it seems correct at first glance.
Perhaps old code hides a bug in the bios... Well, i don't know, I'm not
enough aware of apm or vm86 internals to understand what's happening.

Cheers,
Willy
