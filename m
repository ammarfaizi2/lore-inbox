Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129035AbRBHWNf>; Thu, 8 Feb 2001 17:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129036AbRBHWN0>; Thu, 8 Feb 2001 17:13:26 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:7164 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129035AbRBHWNL>; Thu, 8 Feb 2001 17:13:11 -0500
Date: Thu, 8 Feb 2001 20:12:39 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <E14QwU4-0004QE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102082005400.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Alan Cox wrote:

> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 2.4.1-ac7
> o	Rebalance the 2.4.1 VM				(Rik van Riel)
> 	| This should make things feel a lot faster especially
> 	| on small boxes .. feedback to Rik

I'd really like feedback from people when it comes to this
change. The change /should/ fix most paging performance bugs
because it makes kswapd do the right amount of work in order
to solve the free memory shortage every time it is run.

This, in turn, should make it far less likely that user processes
will *ever* need to call try_to_free_pages() themselves, unless
the system really goes into overload mode.

It would be good to know if this change really fixes the bug or
if it only helps for certain workloads and not for others. I'd
really like to close the following bug but need confirmation
that it works first ;)

http://distro.conectiva.com/bugzilla/show_bug.cgi?id=1178

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
