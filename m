Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSF1DRB>; Thu, 27 Jun 2002 23:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317040AbSF1DRA>; Thu, 27 Jun 2002 23:17:00 -0400
Received: from [209.184.141.190] ([209.184.141.190]:36038 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317037AbSF1DQ7>;
	Thu, 27 Jun 2002 23:16:59 -0400
Subject: Re: vm fixes for 2.4.19rc1
From: Austin Gonyou <austin@digitalroadkill.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020627201413.GD1457@inspiron.ols.wavesec.org>
References: <20020627201413.GD1457@inspiron.ols.wavesec.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 27 Jun 2002 22:19:14 -0500
Message-Id: <1025234354.2087.10.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For something like DB work, would this patch be *too* aggressive on
freeing memory/cache as to introduced increased latency there?
Just curious, I'm all for using *any* good VM changes. 

On Thu, 2002-06-27 at 15:14, Andrea Arcangeli wrote:
> some fix for 2.4.19rc1 (btw, the lru_cache_del() in the LRU path is
> needed in 2.5 too and it's also more efficient than the
> page_cache_release, see ptrace freeing the anon pages with put_page(),
> it will not pass through page_cache_release and it will trigger the
> PageLRU check that __free_pages_ok isn't capable to handle in 2.5, I
> will make a full vm update for 2.5 [in small pieces based on post-Andrew
> split of the monolithic patch] in the next days anyways):



-- 
Austin Gonyou <austin@digitalroadkill.net>
