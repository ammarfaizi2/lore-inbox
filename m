Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131841AbRCXW3D>; Sat, 24 Mar 2001 17:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131842AbRCXW2w>; Sat, 24 Mar 2001 17:28:52 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:54033 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131841AbRCXW2e>; Sat, 24 Mar 2001 17:28:34 -0500
Date: Sat, 24 Mar 2001 19:11:28 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: Doug Ledford <dledford@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <l0313031ab6e2b9537342@[192.168.239.101]>
Message-ID: <Pine.LNX.4.21.0103241910340.1863-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001, Jonathan Morton wrote:

>         free = atomic_read(&buffermem_pages);
>         free += atomic_read(&page_cache_size);
>         free += nr_free_pages();
> -       free += nr_swap_pages;

> +       /* Since getting swap info is expensive, see if our allocation can happen in physical RAM */

Actually, getting swap info is as cheap as reading the variable
nr_swap_pages. I should fix this in the OOM killer ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

