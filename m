Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRHFBSm>; Sun, 5 Aug 2001 21:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRHFBSc>; Sun, 5 Aug 2001 21:18:32 -0400
Received: from [63.209.4.196] ([63.209.4.196]:23568 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266150AbRHFBSX>; Sun, 5 Aug 2001 21:18:23 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /proc/<n>/maps getting _VERY_ long
Date: 5 Aug 2001 18:17:47 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9kkr7r$mov$1@cesium.transmeta.com>
In-Reply-To: <20010805171202.A20716@weta.f00f.org> <200108052341.f75Nfhx08227@penguin.transmeta.com> <20010805204143.A18899@alcove.wittsend.com> <9kkq9k$829$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <9kkq9k$829$1@penguin.transmeta.com>
By author:    torvalds@transmeta.com (Linus Torvalds)
In newsgroup: linux.dev.kernel
>
> In article <20010805204143.A18899@alcove.wittsend.com>,
> Michael H. Warfield <mhw@wittsend.com> wrote:
> >On Sun, Aug 05, 2001 at 04:41:43PM -0700, Linus Torvalds wrote:
> >
> >> We could merge more, but I'm not interested in working around broken
> >
> >	If it only causes problems for the broken app, that's fine.  If it
> >causes problems for the rest of the system, that could be bad.
> 
> It only causes problem for the broken app. Even then, the problem is a
> (likely undetectable) slowdown, or in the extreme case the kernel will
> just tell it that "Ok, you've allocated enough, no more soup for you".
> 

Do you count applications which selectively mprotect()'s memory (to
trap SIGSEGV and maintain coherency with on-disk data structures) as
"broken applications"?

Such applications *can* use large amounts of mprotect()'s.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
