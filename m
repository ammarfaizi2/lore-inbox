Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269822AbRHDHZE>; Sat, 4 Aug 2001 03:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269824AbRHDHYy>; Sat, 4 Aug 2001 03:24:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56070 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269822AbRHDHYj>; Sat, 4 Aug 2001 03:24:39 -0400
Date: Sat, 4 Aug 2001 02:55:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Tridgell <tridge@valinux.com>, lkml <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.8preX VM problems
In-Reply-To: <20010804025008.A30349@krispykreme>
Message-ID: <Pine.LNX.4.21.0108040253030.9719-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Anton Blanchard wrote:

>  
> Hi Marcelo,
> 
> > The problem is pretty nasty: if there is no global shortage and only a 
> > given zone with shortage, we set the zone free target to freepages.min
> > (basically no tasks can make progress with that amount of free memory). 
> 
> Paulus and I were seeing the same problem on a ppc with 2.4.8-pre3. We
> were doing cat > /dev/null of about 5G of data, when we had close to 3G of
> page cache kswapd chewed up all the cpu. Our guess was that there was a
> shortage of lowmem pages (everything above 512M is highmem on the ppc32
> kernel so there isnt much lowmem).
> 
> The patch below allowed us to get close to 4G of page cache before
> things slowed down again and kswapd took over.

How much memory do you have on the box ?

