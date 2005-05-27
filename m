Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVE0Xle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVE0Xle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 19:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVE0Xle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 19:41:34 -0400
Received: from mail.dif.dk ([193.138.115.101]:1503 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262661AbVE0XlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 19:41:23 -0400
Date: Sat, 28 May 2005 01:46:00 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Kill signed chars !!! [was Re: 2.6.12-rc5-mm1]
In-Reply-To: <1117232503l.24619l.1l@werewolf.able.es>
Message-ID: <Pine.LNX.4.62.0505280142260.2370@dragon.hyggekrogen.localhost>
References: <20050525134933.5c22234a.akpm@osdl.org> <1117232503l.24619l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, J.A. Magallon wrote:

> ... and make gcc4 happy.
> 
> On 05.25, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/
> > 
> > 
> > - Again, if there are patches in here which you think should be merged in
> >   2.6.12, please point them out to me.
> > 
> 
> scripts/ is full of mismatches between char* params an signed char* arguments,
> and viceversa. gcc4 now complaints loud about this. Patch below deletes all
> those 'signed'. Anyways, which was the purpose of declaring 'signed char's
> to store text ?

Not commenting on your specific patch here, just the bit about what the 
point is of using explicitly signed chars. C doesn't define if chars are 
signed or unsigned by default, that's up to the implementation. So if it 
matters to you that chars should be either signed or unsigned you have to 
explicitly specify them as signed or unsigned.
I haven't read the code you change, not the patch, so I don't know if it's 
an issue, but there are certainly arguments for explicitly specifying  
signed char  or  unsigned char  in C code.


-- 
Jesper Juhl

