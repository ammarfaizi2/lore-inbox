Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSJYQrV>; Fri, 25 Oct 2002 12:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbSJYQrV>; Fri, 25 Oct 2002 12:47:21 -0400
Received: from 1-116.ctame701-1.telepar.net.br ([200.181.137.116]:37045 "EHLO
	1-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261486AbSJYQrV>; Fri, 25 Oct 2002 12:47:21 -0400
Date: Fri, 25 Oct 2002 14:53:15 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Hugh Dickins <hugh@veritas.com>, <cmm@us.ibm.com>,
       <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>,
       <dipankar@in.ibm.com>, <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH]updated ipc lock patch
In-Reply-To: <3DB88298.735FD044@digeo.com>
Message-ID: <Pine.LNX.4.44L.0210251451460.1995-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, Andrew Morton wrote:

> And it seems that if the kmalloc fails, we decide to leak some
> memory, yes?
>
> If so it would be better to use GFP_ATOMIC there.  Avoids any
> locking problems and also increases the chance of the allocation
> succeeding.  (With an explanatory comment, naturally :)).

Actually, under memory load GFP_KERNEL will wait for the
memory to become available, while GFP_ATOMIC will fail.

Using GFP_ATOMIC here will probably increase the risk of
a memory leak.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

