Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135225AbRBEQQn>; Mon, 5 Feb 2001 11:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133111AbRBEQQd>; Mon, 5 Feb 2001 11:16:33 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:40949 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130775AbRBEQQV>; Mon, 5 Feb 2001 11:16:21 -0500
Date: Mon, 5 Feb 2001 14:15:30 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: LA Walsh <law@sgi.com>
cc: Delta <birtl00@dmi.usherb.ca>, linux-kernel@vger.kernel.org
Subject: Re: System unresponsitive when copying HD/HD
In-Reply-To: <3A7C64F9.F3192611@sgi.com>
Message-ID: <Pine.LNX.4.21.0102051410090.1311-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2001, LA Walsh wrote:

> I've noticed less responsive disk response on 2.4.0 vs. 2.2.17.  
> For example -- I run vmware and suspend it frequently when I'm
> not using it.  One of them requires a 158Mb save file.  Before,
> I could suspend that one, then start another which reads in a
> smaller 50M save file.  The smaller one would come up while the
> other was still saving.  As of 2.4, the smaller one doesn't come
> up -- I can't even do an 'ls' until the big save finishes.

[snip]

This could be related with (from the linux-mm bugzilla):

  http://distro.conectiva.com/bugzilla/show_bug.cgi?id=1178

I have a patch against 2.4.1 and 2.4.1-ac which {c,sh}ould
fix this bug, but I don't know if it will fix your situation.
If your problem still happens with this patch, let me know and
I'll see how I can fix it:

  http://www.surriel.com/patches/2.4/2.4.1-vmpatch

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
