Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSLFM7l>; Fri, 6 Dec 2002 07:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSLFM7l>; Fri, 6 Dec 2002 07:59:41 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:50388 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262430AbSLFM7k>; Fri, 6 Dec 2002 07:59:40 -0500
Date: Fri, 6 Dec 2002 11:07:00 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Rusty Trivial Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, "" <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>
Subject: Re: [TRIVIAL] Re: setrlimit incorrectly allows hard limits to exceed
 soft limits
In-Reply-To: <20021206035756.2CD1A2C28C@lists.samba.org>
Message-ID: <Pine.LNX.4.50L.0212061106050.22252-100000@duckman.distro.conectiva>
References: <20021206035756.2CD1A2C28C@lists.samba.org>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002, Rusty Trivial Russell wrote:

> > Just try "ulimit -H -m 10000" for memory limits that were not
> > previously set.  You end up with (hard limit = 10000) < (soft limit =
> > unlimited).

> +       if (new_rlim.rlim_cur > new_rlim.rlim_max)
> +               return -EINVAL;

Wouldn't it be better to simply take the soft limit down
to min(new_rlim.rlim_cur, new_rlim.rlim_max) ?

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?
http://www.surriel.com/		http://guru.conectiva.com/
