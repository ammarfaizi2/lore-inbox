Return-Path: <linux-kernel-owner+w=401wt.eu-S964784AbXAHJGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbXAHJGP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbXAHJGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:06:15 -0500
Received: from web55603.mail.re4.yahoo.com ([206.190.58.227]:39507 "HELO
	web55603.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932635AbXAHJGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:06:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=cH8aXkfv4qkXhcs4ODpozTJLtHuFy6LBiDfk3DxLgLFoHU3L+uatBbdj/PVW9YswkyHjFecHJd0k1zuXFKil4d1XweOboBKMqql2U2u4P6j5F0ywEnJKT/FM055uzIJO98w9GJ2QV2HV4r0w9mn7toG94W17oKPdF5sY5WUsmPc=;
X-YMail-OSG: K8DZ4TMVM1kcbrUbZq6lg0rOQZapKxgJNJ0GML692XvSRWa9.1i4oEdeHyu00C51pIO.hYcee9QAVH4N7GMLEQwcaQgjLaJ0S6ZmeKuxvmUfCIkzwAHyptcqs2ZkHBLsMTqFnghw3X7RPzxRfyAAEB4GeA--
Date: Mon, 8 Jan 2007 01:06:12 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Hua Zhong <hzhong@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f020701080045x52b1b9a3u8caf8b88856ceb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <552712.75479.qm@web55603.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> Hi Amit,
> 
> On 1/8/07, Amit Choudhary <amit2030@yahoo.com> wrote:
> > Man, doesn't make sense to me.
> 
> Well, man, double-free is a programming error and papering over it
> with NULL initializations bloats the kernel and makes the code
> confusing.
> 
> Clear enough for you?
> 

It is a programming error because the underlying code cannot handle it. If, from the beginning of
time, double free would have been handled properly then we wouldn't have thought twice about it.

You want to catch double frees. What if double frees are no-ops?

I do not see how a double free can result in _logical_wrong_behaviour_ of the program and the
program keeps on running (like an incoming packet being dropped because of double free). Double
free will _only_and_only_ result in system crash that can be solved by setting 'x' to NULL.

-Amit



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
