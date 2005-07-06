Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVGFKy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVGFKy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVGFKvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:51:04 -0400
Received: from [203.171.93.254] ([203.171.93.254]:41365 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262226AbVGFI3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:29:18 -0400
Subject: Re: [PATCH] [14/48] Suspend2 2.1.9.8 for 2.6.12:
	404-check-mounts-support.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050706081523.GD1412@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164403506@foobar.com>
	 <20050706081523.GD1412@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120638643.4860.42.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 18:30:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Sorry.

It's not really a bug in the swapoff code. Rather, clearing this field
allows simple identification of the devices being used for swap (for
flushing writes).

Regards,

Nigel

On Wed, 2005-07-06 at 18:15, Pavel Machek wrote:
> On St 06-07-05 12:20:40, Nigel Cunningham wrote:
> > diff -ruNp 405-clear-swapfile-bdev-in-swapoff.patch-old/mm/swapfile.c 405-clear-swapfile-bdev-in-swapoff.patch-new/mm/swapfile.c
> > --- 405-clear-swapfile-bdev-in-swapoff.patch-old/mm/swapfile.c	2005-07-06 11:22:01.000000000 +1000
> > +++ 405-clear-swapfile-bdev-in-swapoff.patch-new/mm/swapfile.c	2005-07-04 23:14:19.000000000 +1000
> > @@ -1162,6 +1162,7 @@ asmlinkage long sys_swapoff(const char _
> >  	swap_file = p->swap_file;
> >  	p->swap_file = NULL;
> >  	p->max = 0;
> > +	p->bdev = NULL;
> >  	swap_map = p->swap_map;
> >  	p->swap_map = NULL;
> >  	p->flags = 0;
> 
> I guess some explanation is needed here; and if it is bugfix it should
> just go in...
> 								Pavel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

