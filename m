Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRKSJXL>; Mon, 19 Nov 2001 04:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRKSJXB>; Mon, 19 Nov 2001 04:23:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62103 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276344AbRKSJWv>;
	Mon, 19 Nov 2001 04:22:51 -0500
Date: Mon, 19 Nov 2001 04:22:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: more fun with procfs (netfilter)
In-Reply-To: <E165kY1-0000Se-00@gondolin.me.apana.org.au>
Message-ID: <Pine.GSO.4.21.0111190419250.17210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Nov 2001, Herbert Xu wrote:

> Alexander Viro <viro@math.psu.edu> wrote:
> 
> > PS: with bash-2.03:
> > $ while read i; do echo $i; done < /proc/ip_tables_names
> > $ while read i; do echo $i; done < /proc/ip_conntrack
> > $
> > 'cause this beast reads byte-by-byte...
> 
> Actually, there is no easy way of implementing a read(1) that doesn't
> read byte-by-byte...

Some shells (pdksh 5.2.14-1, bash 2.04 as shipped by SuSE) are trying to be
smart if stdin is from regular file - they hope that third argument of
lseek() is in bytes and is consistent with read() return value.

