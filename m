Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290708AbSAROnR>; Fri, 18 Jan 2002 09:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290707AbSAROnI>; Fri, 18 Jan 2002 09:43:08 -0500
Received: from mxzilla4.xs4all.nl ([194.109.6.48]:19468 "EHLO
	mxzilla4.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290708AbSAROnA>; Fri, 18 Jan 2002 09:43:00 -0500
Date: Fri, 18 Jan 2002 15:42:39 +0100
From: Tommy Faasen <faasen@xs4all.nl>
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: vm philosophising
Message-ID: <20020118154239.A11920@xs4all.nl>
In-Reply-To: <Pine.LNX.4.33.0201180522020.19716-100000@falcon.etf.bg.ac.yu> <Pine.LNX.4.33L.0201180235210.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0201180235210.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Jan 18, 2002 at 02:36:02AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 02:36:02AM -0200, Rik van Riel wrote:
> On Fri, 18 Jan 2002, Bosko Radivojevic wrote:
> 
> > There is no way to make one good VM for all possible situations. But,
> > you can tune/make one VM to work great on large DBMS (e.g.) and
> > tune/make another one to work great on ordinary desktop systems
> 
> This is an interesting assertion ... but up to date nobody has
> been able to tell me what exactly should be different between
> these two mythical VMs ;)
> 
I have no clue about VM's but I can imagine that for example the following situations have different requirements:
1-Desktop: many "small" apps, I believe exe's remain in memory and data is written to disk? Anyway I can imagine fragmentation and latency is an issue here.
2-DBMS: 1 or 2 big programs which sometimes even do their own memory management.Fragmentation and latency isn't issue here I think however moving ltos of data to and from swap is.
3-Webserver: for example apache with many childs being created under high load and killed under low load. The data is always small (in case of static pages). So a lot of small swaps? Latency is not as much as un issue but I can imagine that fragmentation can be an issue?

I think these 3 situations behave very differently, but then again it's just what I think. I can also imagine that more situations are possible but not many.
I also indictated that we have a few parameters we can optimise for like latency, fragmentation and moving a lot small chunks, or occasionally 1 big chunk.

I know from an AI perspective that optimize for 3 different parameters is difficult.
> regards,
> 
> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
