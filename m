Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279591AbRKROSw>; Sun, 18 Nov 2001 09:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279631AbRKROSl>; Sun, 18 Nov 2001 09:18:41 -0500
Received: from ns.suse.de ([213.95.15.193]:54796 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279591AbRKROS1>;
	Sun, 18 Nov 2001 09:18:27 -0500
Date: Sun, 18 Nov 2001 15:18:18 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] moving F0 0F bug check to bugs.h
In-Reply-To: <Pine.LNX.4.33.0111181540190.16977-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.30.0111181512230.29315-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Zwane Mwaikambo wrote:

> Is there any reason why the F0 0F bug check isn't in bugs.h?

hpa moved it (And some others) during his 2.3.99 big cleanup of setup.c
and friends.

> We only check for the bug once so we might as well move it to check
> the boot cpu only in bugs.h.

Whilst not an ideal solution, some people do silly things like
putting a P150 and a P166 clocked to 150 into SMP boxes.
It could be possible for 1 CPU to have the bug whilst another doesn't.

It's questionable we should support such nightmare scenarios, but
as this is __initcode anyway, it's not that big a deal.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

