Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266171AbTGDUlb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbTGDUlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:41:31 -0400
Received: from aneto.able.es ([212.97.163.22]:25491 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S266171AbTGDUla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:41:30 -0400
Date: Fri, 4 Jul 2003 22:55:56 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] do_generic_direct_write
Message-ID: <20030704205556.GA4146@werewolf.able.es>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva> <20030627233649.GC9706@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030627233649.GC9706@werewolf.able.es>; from jamagallon@able.es on Sat, Jun 28, 2003 at 01:36:49 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.28, J.A. Magallon wrote:
> 
> On 06.27, Marcelo Tosatti wrote:
> > 
> > Hello,
> > 
> > Here goes -pre2 with a big number of changes, including the new aic7xxx
> > driver.
> > 
> > I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> > short.
> > 
> 
> Correct me if I'm wrong. I found this just by chance:
> 
> mm/filemap.c:
> ssize_t
> do_generic_direct_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
> ...
> 
>     if (!file->f_flags & O_DIRECT)
>         BUG();
> 
> This fails to trigger the BUG() just when it should. This should be:
> 
>     if (!(file->f_flags & O_DIRECT))
>         BUG();

Someone can confirm this / flame me , plz ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre2-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
