Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281799AbRKQSjb>; Sat, 17 Nov 2001 13:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281802AbRKQSjV>; Sat, 17 Nov 2001 13:39:21 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:53767 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281799AbRKQSjF>;
	Sat, 17 Nov 2001 13:39:05 -0500
Date: Sat, 17 Nov 2001 16:38:56 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: mmap not working?
In-Reply-To: <200111170907.KAA24566@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.33L.0111171637240.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2001, Rogier Wolff wrote:

> The SGI manpage says:
>
>      All implementations interpret an addr value of
>      zero as granting the system complete freedom in selecting pa, subject to
>      constraints described below.  A non-zero value of addr is taken to be a
>      suggestion of a process address near which the mapping should be placed.
       ^^^^^^^^^^

The key word here is "suggestion".  There is absolutely no
requirement that the OS actually uses this address.

> which hints at a possible non-alignment. It also mentions that
> "offset" should be page-aligned, which I disagree with here:
> everything has been set up to "do the right thing" when the mapping is
> possible with an unaligned offset.

I don't know what MMU your machine has, but on most (if not
all) machines an mmap() is only possible when it's page-aligned.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

