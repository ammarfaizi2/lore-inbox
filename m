Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312393AbSDCWAj>; Wed, 3 Apr 2002 17:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312354AbSDCWAT>; Wed, 3 Apr 2002 17:00:19 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:49165 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S312314AbSDCWAI>; Wed, 3 Apr 2002 17:00:08 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Date: 3 Apr 2002 20:35:06 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnaamprq.tuj.kraxel@bytesex.org>
In-Reply-To: <Pine.LNX.4.33.0204031106420.3004-100000@penguin.transmeta.com> <E16sqaK-0004MO-00@the-village.bc.nu>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1017866106 30972 127.0.0.1 (3 Apr 2002 20:35:06 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > The fact that the code was back-ported from 2.5.x and that the _GPL still 
> > is there too is just a mistake, partly because I've not gotten any updates 
> > from Ingo..
>  
>  So Linus is allowed to arbitarily export other peoples contributions ? I
>  think we need to clear this one up and understand what people think the
>  actual rules are around here. As I understand it the original code was
>  a) extracted from bttv and is code which I and DaveM partly wrote
>  b) was submitted by Gerd who did the extra work and kept it as _GPL when he 
>     first exported it. (in 2.4 its relevant to expose it as we have the V4L1
>     not V4L2 interface)

No.

I've only submitted the 2.4.x backport to Marcelo, and the only reason
I've export it as _GPL there is that it is _GPL in 2.5.x.  Having that
symbol without _GPL in 2.4 and with _GPL in 2.5 would be very bad style
and would upset people who start using that function in 2.4 and notice
later on that it is exported more strict in 2.5 ...

I'll happily submit a patch to Marcelo to remove the _GPL once it is
gone in Linus 2.5 tree.

The 2.5.x code (which I grabbed for the backport) was submitted by Ingo
and updated by Linus says my BK tree changelog.  Ingo obviously did
*not* a simple cut&paste of DaveM's code from bttv.  The 2.5.x
vmalloc_to_page() function handles pte-highmem and preemtable kernels,
that code was never in bttv.

>  Nobody seems to have remembered to ask permission around here

Ingo is happy with removing _GPL, Linus too, where exactly is the
problem?

  Gerd

-- 
#include </dev/tty>
