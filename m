Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264660AbRFPV1E>; Sat, 16 Jun 2001 17:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264661AbRFPV0o>; Sat, 16 Jun 2001 17:26:44 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:3344 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264660AbRFPV0e>;
	Sat, 16 Jun 2001 17:26:34 -0400
Date: Sat, 16 Jun 2001 18:25:54 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
In-Reply-To: <Pine.LNX.4.21.0106161801220.2056-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0106161825060.2056-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2001, Rik van Riel wrote:


Oops, I did something stupid and the patch is reversed ;)


> --- buffer.c.orig	Sat Jun 16 18:05:15 2001
> +++ buffer.c	Sat Jun 16 18:05:29 2001
> @@ -2550,8 +2550,7 @@
>  			   if the current bh is not yet timed out,
>  			   then also all the following bhs
>  			   will be too young. */
> -			if (++flushed > bdf_prm.b_un.ndirty &&
> -					time_before(jiffies, bh->b_flushtime))
> +			if(time_before(jiffies, bh->b_flushtime))
>  				goto out_unlock;
>  		} else {
>  			if (++flushed > bdf_prm.b_un.ndirty)


Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

