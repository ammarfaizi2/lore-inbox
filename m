Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316995AbSF0Ulo>; Thu, 27 Jun 2002 16:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSF0Uln>; Thu, 27 Jun 2002 16:41:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25632 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316995AbSF0Ulm>; Thu, 27 Jun 2002 16:41:42 -0400
Date: Thu, 27 Jun 2002 16:43:28 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: vm fixes for 2.4.19rc1
Message-ID: <20020627204328.GE1457@inspiron.ols.wavesec.org>
References: <20020627201413.GD1457@inspiron.ols.wavesec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020627201413.GD1457@inspiron.ols.wavesec.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2002 at 04:14:13PM -0400, Andrea Arcangeli wrote:
>  					if (PageLocked(page))
>  						BUG();
>  					if (PageLRU(page))
> -						BUG();
> +						lru_cache_del(page);
> 
> 
> This fixes a bug I found two days ago, it could explain the nvidia

please don't add the above one liner, on a second thought it wasn't a
bug here because we add to the local list only after running
lru_cache_del, so it still has to be an issue with the nvidia drivers,
but everything else in the previous patch still is valid :), however
nothing high prio here.

Andrea
