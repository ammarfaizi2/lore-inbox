Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTEYUlQ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTEYUlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:41:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18666 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263760AbTEYUlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:41:06 -0400
Date: Sun, 25 May 2003 22:54:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
   ncorbic@sangoma.com, dm@sangoma.com
Subject: 2.5.69-mm9: undefined references to `router_devlist'
Message-ID: <20030525205409.GF16791@fs.tum.de>
References: <20030525042759.6edacd62.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525042759.6edacd62.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following link error comes from Linus' tree:

<--  snip  -->

...
386/oprofile/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
...
net/built-in.o(.text+0x10b278): In function `r_start':
: undefined reference to `router_devlist'
net/built-in.o(.text+0x10b321): In function `r_next':
: undefined reference to `router_devlist'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

r_start and r_next are in net/wanrouter/wanproc.c.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

