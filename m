Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSJJALj>; Wed, 9 Oct 2002 20:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbSJJALi>; Wed, 9 Oct 2002 20:11:38 -0400
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:3970 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262312AbSJJALi>;
	Wed, 9 Oct 2002 20:11:38 -0400
Date: Thu, 10 Oct 2002 01:16:41 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andreas Dilger <adilger@clusterfs.com>, Robert Love <rml@tech9.net>,
       Marco Colombo <marco@esi.it>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021010001641.GE2654@bjl1.asuk.net>
References: <20021009152731.GY3045@clusterfs.com> <Pine.LNX.4.44L.0210092045195.22735-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210092045195.22735-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> > I would say - if you are picking a new flag that doesn't need to have
> > compatibility with any platform-specific existing flag, simply set them
> > all high enough so that they are the same on all platforms.
> 
> Doesn't really matter, you can't run x86 binaries on MIPS so
> you need to recompile anyway.
> 
> Source level compatibility is enough for flags like this.

Using the _same_ flag on different architectures can simplify the
kernel source, though.  Just imagine, a set of O_* definitions in
<linux/fcntl.h> instead of them being duplicated, with different
definitions, throughout <asm-*/fcntl.h>.

-- Jamie
