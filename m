Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268997AbRHRWco>; Sat, 18 Aug 2001 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268996AbRHRWce>; Sat, 18 Aug 2001 18:32:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58377 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268997AbRHRWcY>; Sat, 18 Aug 2001 18:32:24 -0400
Subject: Re: 2.4.8 Resource leaks + limits
To: riel@conectiva.com.br (Rik van Riel)
Date: Sat, 18 Aug 2001 23:34:31 +0100 (BST)
Cc: szaka@f-secure.com (Szabolcs Szakacsits),
        mag@fbab.net ("Magnus Naeslund(f)"),
        viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org (linux-kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33L.0108181218380.5646-100000@imladris.rielhome.conectiva> from "Rik van Riel" at Aug 18, 2001 12:20:26 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YEfn-0001oz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, 18 Aug 2001, Szabolcs Szakacsits wrote:
> > On Fri, 17 Aug 2001, Rik van Riel wrote:
> > > The fix is to disable the check for RLIMIT_NPROC in
> > > kernel/fork.c when the user is root. I made this patch
> 
> > Everybody told him, including Alan, go away and fix PAM. He went away
> > and fixed PAM in 2 days. Up to day none of the main distributions ship
> > the correct[ly configured] PAM, so the problem still bites. Feel free
> > to rebut me.
> 
> Wouldn't that involve fixing login, sshd, and all other
> programs using pam to set the limits before fork()ing ?
> 
> I know the pam library is responsible for setting the
> user limits, but it's the program linked to libpam which
> is responsible for the order in which the other things
> are done, right ?
> 
> (then again, I don't know enough about the userspace side
> of things here, I'd be happy if somebody could enlighten
> me)
> 
> cheers,
> 
> Rik
> --
> IA64: a worthy successor to i860.
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

