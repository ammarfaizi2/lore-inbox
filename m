Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSKCDhS>; Sat, 2 Nov 2002 22:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSKCDhS>; Sat, 2 Nov 2002 22:37:18 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:41617 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S261582AbSKCDhR>; Sat, 2 Nov 2002 22:37:17 -0500
Date: Sat, 02 Nov 2002 21:43:12 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3DC415DA.29D22E92@digeo.com>
References: <20021102060423.032A.AT541@columbia.edu> <3DC415DA.29D22E92@digeo.com>
Message-Id: <20021102210737.3794.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop015.verizon.net from [138.89.32.225] at Sat, 2 Nov 2002 21:43:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Nov 2002 10:13:46 -0800
Andrew Morton <akpm@digeo.com> mentioned:
> Akira Tsukamoto wrote:
> > > size by 17 kbytes, which is larger than my entire Layer 1 instruction
> > > cache!
> > 
> > It is because I was working on this patch based on 2.5.44 :)

Oh, Oh,
I meant the above that I *do* agree you. I just wanted to say,
two function was kept inline because from before 2.4 until though 2.5.44,
it was inlined, and when I received the faster-intel-copy from
Takahashi, I was working my patch against 2.5.44.

Just move __copy_to/from_user to usercopy.c will decrease the 
kernel size and should be almost the same as before. 
Am I missing something?

> - cache misses are slow
> - kernel has no right to be evicting user code from the CPU cache

Is this relevant to this patch?
I did not change any in my patch about it.

> - subroutine calls are fast

You mean almost no overhead.

> - smaller is faster

It could be said more efficient but faster?
The code or binary size directly connected to this issue?

> - inlining to the point of increasing code size is probably wrong

I agree, as my first comment.



