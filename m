Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275752AbRJUJrb>; Sun, 21 Oct 2001 05:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275778AbRJUJrV>; Sun, 21 Oct 2001 05:47:21 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:9995 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S275752AbRJUJrH>;
	Sun, 21 Oct 2001 05:47:07 -0400
Date: Sun, 21 Oct 2001 07:47:28 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: D Campbell <dcampbel_slo@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kswapd is CPU-hungry (kernel 2.4.2-2)
In-Reply-To: <20011021023402.77126.qmail@web20707.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L.0110210735230.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Oct 2001, D Campbell wrote:

> after searching the archives i'm still a bit concerned
> about the CPU usage of kswapd on a machine with lots of memory.
>
> summary:
> kswapd at 66% CPU.  1G RAM.  ~800M taken by ramdisks.  no swap.

OK, I think the problem is that the system allocates so much
highmem pages for the ramdisk that it's become impossible for
kswapd to ever meet the free target.

I _think_ this has been fixed in a more recent -ac kernel,
but haven't tested it with such a huge ramdisk...

If it is possible, could you test 2.4.12-ac3 ?
(if it's still broken, I'll go fix it)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

