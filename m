Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130156AbRBZF3W>; Mon, 26 Feb 2001 00:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbRBZF3N>; Mon, 26 Feb 2001 00:29:13 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:39177 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S130155AbRBZF24>; Mon, 26 Feb 2001 00:28:56 -0500
Date: Mon, 26 Feb 2001 00:42:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Shawn Starr <spstarr@sh0n.net>, lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Patch failed
In-Reply-To: <Pine.LNX.4.33.0102250848340.2015-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0102260029300.4659-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Feb 2001, Mike Galbraith wrote:

> The way sg_low_malloc() tries to allocate, failure messages are
> pretty much garanteed.  It tries high order allocations (which
> are unreliable even when not stressed) and backs off until it
> succeeds.
> 
> In other words, the messages are a red herring.

Yup. And they should not be printed. 

We can add an allocation flag (__GFP_NO_CRITICAL?) which can be used by
sg_low_malloc() (and other non critical allocations) to fail previously
and not print the message. 

Linus ? 


