Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273975AbRIXQGg>; Mon, 24 Sep 2001 12:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273976AbRIXQG0>; Mon, 24 Sep 2001 12:06:26 -0400
Received: from ns.suse.de ([213.95.15.193]:49413 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S273975AbRIXQGS>;
	Mon, 24 Sep 2001 12:06:18 -0400
Date: Mon, 24 Sep 2001 18:06:43 +0200
From: Olaf Hering <olh@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010924180643.A17613@suse.de>
In-Reply-To: <20010924040208.A624@localhost.localdomain> <Pine.LNX.4.21.0109240810300.1593-100000@freak.distro.conectiva> <20010924175419.A30742@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010924175419.A30742@suse.de>; from olh@suse.de on Mon, Sep 24, 2001 at 05:54:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, Olaf Hering wrote:

> mandarine:~ # vmstat
>    procs                      memory    swap          io     system
> cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
> sy  id
>  3  0  1      0   2744  53944 1794968   0   0   440   343   75   300  14
> 28  58
> mandarine:~ # free
> Killed
> 
> 
> That did not happen with pre10aa1, at least the OOM kills.
> I happend with a bk pull, a build in the background. I seems that it
> doesnt release some memory...

it seems that the cache grows and grows, one bk process was still active. No idea
who to blame, but it should not kill the box :)

27429 pts/0    D      3:59 bk idcache -q


Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
