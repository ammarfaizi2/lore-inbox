Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWJQNXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWJQNXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWJQNXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:23:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30617 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750910AbWJQNXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:23:11 -0400
Message-Id: <200610171058.k9HAwUIo003086@laptop13.inf.utfsm.cl>
To: mfbaustx <mfbaustx@gmail.com>
cc: "Oliver Neukum" <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: copy_from_user / copy_to_user with no swap space 
In-Reply-To: Message from mfbaustx <mfbaustx@gmail.com> 
   of "Mon, 16 Oct 2006 14:47:13 CDT." <op.thi48zvznwjy9v@titan> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Tue, 17 Oct 2006 07:58:30 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 17 Oct 2006 10:22:51 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mfbaustx <mfbaustx@gmail.com> wrote:
> >>> No. Your code may be only partially paged into RAM.
> >>> The same can happen for any mmaped data.

> That's what I thought I read.  But then my question is:  with
> on-demand  paging, is it possible to have two processes partially
> paged?

Why shouldn't they be? The whole idea is having just /parts/ (hopefully the
ones in active use) in memory.

>         Surely, it  MUST be the case that any processes with
> overlapping logical address  spaces must be paged coherently.

I don't know what this is supposed to mean...

>                                                                So,
> while on-demand "paging-in" allows  for partial paging of a process,
> is it the case that, on a context switch,  the user-space PTE's are
> completely erased (so that you get page-faults  and can then on-demand
> page them in...)?

Each process has its own page tables, they don't get in each others
hair. And the page tables precisely manage making several processes get
access to the /same/ logical addresses, but at /different/ physical
addresses.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
