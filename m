Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSLHOlg>; Sun, 8 Dec 2002 09:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLHOlg>; Sun, 8 Dec 2002 09:41:36 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:44448 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261286AbSLHOlf>; Sun, 8 Dec 2002 09:41:35 -0500
Date: Sun, 8 Dec 2002 12:49:00 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Anton Blanchard <anton@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-BK + 24 CPUs
In-Reply-To: <20021208130908.GE19698@krispykreme>
Message-ID: <Pine.LNX.4.50L.0212081246570.21756-100000@imladris.surriel.com>
References: <20021208130908.GE19698@krispykreme>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2002, Anton Blanchard wrote:

> profile:
>  66260 total
>  54227 cpu_idle
>   1000 page_remove_rmap
>    909 __get_page_state
>    830 page_add_rmap

Looks like the bitflag locking in rmap is hurting you.
How does it work with a real spinlock in the struct page
instead of using a bit in page->flags ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
