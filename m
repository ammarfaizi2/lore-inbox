Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135296AbRDZLGe>; Thu, 26 Apr 2001 07:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135310AbRDZLGY>; Thu, 26 Apr 2001 07:06:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6159 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135296AbRDZLGM>; Thu, 26 Apr 2001 07:06:12 -0400
Date: Thu, 26 Apr 2001 06:26:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104261121390.313-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0104260619200.1364-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Apr 2001, Mike Galbraith wrote:

> > (i cannot see how this chunk affects the VM, AFAICS this too makes the
> > zapping of the cache less agressive.)
> 
> (more folks get snagged on write.. they can't eat cache so fast)

What about GFP_BUFFER allocations ? :)

I suspect the jiffies hack is avoiding GFP_BUFFER allocations to eat cache
insanely.

Easy way to confirm that: add the kswapd wait queue again and make
allocators which don't have __GFP_IO set wait on that in
try_to_free_pages(). 




