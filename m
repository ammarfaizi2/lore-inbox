Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270206AbRHRPLA>; Sat, 18 Aug 2001 11:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270207AbRHRPKu>; Sat, 18 Aug 2001 11:10:50 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:31759 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S270206AbRHRPKf>; Sat, 18 Aug 2001 11:10:35 -0400
Date: Sat, 18 Aug 2001 18:24:31 +0300 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Magnus Naeslund(f)" <mag@fbab.net>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <Pine.LNX.4.33L.0108171818040.2277-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0108181807440.20413-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Aug 2001, Rik van Riel wrote:
> The fix is to disable the check for RLIMIT_NPROC in
> kernel/fork.c when the user is root. I made this patch
> a while back for Conectiva's kernel RPM and sent it off
> to Alan and Linus.
> This fix was merged in the -ac kernels while Linus just
> ignored it.

That's funny. This problem came up in linux-kernel in last year
November by Jan Rekorajski purposing basically the same patch,
http://groups.google.com/groups?hl=en&safe=off&th=6507453d081541,15&seekm=linux.kernel.20001128221155.G2680%40sith.mimuw.edu.pl#p

Everybody told him, including Alan, go away and fix PAM. He went away
and fixed PAM in 2 days. Up to day none of the main distributions ship
the correct[ly configured] PAM, so the problem still bites. Feel free to
rebut me.

Personally I think Linus was right when he didn't apply the patch. If
one sets RLIMIT_NPROC even for root in a shell, he expects EAGAIN when
limit is hit and not to blow up the system.

	Szaka

