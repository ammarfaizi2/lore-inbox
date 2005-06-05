Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVFEXg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVFEXg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 19:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVFEXg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 19:36:27 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:56587 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261632AbVFEXgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 19:36:24 -0400
Date: Mon, 6 Jun 2005 01:34:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Herbert Rosmanith <kernel@wildsau.enemy.org>, linux-kernel@vger.kernel.org,
       hjl@lucon.org
Subject: Re: 2.4.31 & latest binutils: asm-problems still there
Message-ID: <20050605233459.GB28759@alpha.home.local>
References: <200506040329.j543TWV7029456@wildsau.enemy.org> <20050605181632.GA19297@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605181632.GA19297@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2005 at 03:16:32PM -0300, Marcelo Tosatti wrote:
> On Sat, Jun 04, 2005 at 05:29:31AM +0200, Herbert Rosmanith wrote:
(...)
> > alessandro suardi told me that this problem is solved using the
> > patch from:
> >   http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch
> > 
> > which are dated from march (2005-03-27) and therefore, about 3 months
> > old.
> > 
> > it's about time this gets into the official kernel. who is in charge
> > of it? (it's obviously not sufficient to report to lkml).
> 
> Looks OK except that one "movl" conversion was forgotten in 
> the x86-64 diff:
> 
> @@ -609,7 +609,7 @@ struct task_struct *__switch_to(struct t
>  	}
>  	{
>  		unsigned gsindex;
> -		asm volatile("movl %%gs,%0" : "=g" (gsindex)); 
> +		asm volatile("movl %%gs,%0" : "=r" (gsindex)); 
>  		if (unlikely((gsindex | next->gsindex) || prev->gs)) {
> 
> Who wrote the patch? 

I believe it's H.J. Lu (CC'd).

Willy

