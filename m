Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbRLKNdM>; Tue, 11 Dec 2001 08:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285031AbRLKNdD>; Tue, 11 Dec 2001 08:33:03 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:37894 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S285030AbRLKNcq>;
	Tue, 11 Dec 2001 08:32:46 -0500
Date: Tue, 11 Dec 2001 11:32:25 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <3C15B0B3.1399043B@zip.com.au>
Message-ID: <Pine.LNX.4.33L.0112111130110.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Andrew Morton wrote:

> This test on a 64 megabyte machine, on ext2:
>
> 	time (tar xfz /nfsserver/linux-2.4.16.tar.gz ; sync)
>
> On 2.4.17-pre7 it takes 21 seconds.  On -aa it is much slower: 36 seconds.

> Execution time for `make -j12 bzImage' on a 64meg RAM/512 meg swap
> dual x86:
>
> -aa:					4 minutes 20 seconds
> 2.4.7-pre8				4 minutes 8 seconds
> 2.4.7-pre8 plus the below patch:	3 minutes 55 seconds


Andrea, it seems -aa is not the holy grail VM-wise. If you want
to merge your good stuff with marcelo, please do it in the
"one patch with explanation per problem" style marcelo asked.

If nothing happens I'll take my chainsaw and remove the whole
use-once stuff just so 2.4 will avoid the worst cases, even if
it happens to remove some of the nice stuff you've been working
on.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

