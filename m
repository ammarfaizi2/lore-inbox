Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311615AbSCTNtf>; Wed, 20 Mar 2002 08:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311626AbSCTNtZ>; Wed, 20 Mar 2002 08:49:25 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:58384 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S311611AbSCTNp5>;
	Wed, 20 Mar 2002 08:45:57 -0500
Date: Wed, 20 Mar 2002 10:45:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-110-zone_accounting
In-Reply-To: <3C9808EE.B5C38E84@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0203201043250.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Andrew Morton wrote:

> 1: page_cache_size is no longer an atomic type - it's now just an
>    unsigned long.  It's always altered under pagecache_lock.

Is this change worth it ?   This code will have to be changed
back in any patch trying to fine-grain the pagecache lock...

Alternatively, maybe we should hide the page_cache_size behind
magic macros too, so it's easier to change the underlying data
structure(s).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

