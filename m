Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270221AbRHRPUv>; Sat, 18 Aug 2001 11:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270222AbRHRPUm>; Sat, 18 Aug 2001 11:20:42 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:2823 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270221AbRHRPUd>;
	Sat, 18 Aug 2001 11:20:33 -0400
Date: Sat, 18 Aug 2001 12:20:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: "Magnus Naeslund(f)" <mag@fbab.net>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <Pine.LNX.4.30.0108181807440.20413-100000@fs131-224.f-secure.com>
Message-ID: <Pine.LNX.4.33L.0108181218380.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2001, Szabolcs Szakacsits wrote:
> On Fri, 17 Aug 2001, Rik van Riel wrote:
> > The fix is to disable the check for RLIMIT_NPROC in
> > kernel/fork.c when the user is root. I made this patch

> Everybody told him, including Alan, go away and fix PAM. He went away
> and fixed PAM in 2 days. Up to day none of the main distributions ship
> the correct[ly configured] PAM, so the problem still bites. Feel free
> to rebut me.

Wouldn't that involve fixing login, sshd, and all other
programs using pam to set the limits before fork()ing ?

I know the pam library is responsible for setting the
user limits, but it's the program linked to libpam which
is responsible for the order in which the other things
are done, right ?

(then again, I don't know enough about the userspace side
of things here, I'd be happy if somebody could enlighten
me)

cheers,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

