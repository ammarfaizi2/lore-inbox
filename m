Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbSI1QIA>; Sat, 28 Sep 2002 12:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262081AbSI1QIA>; Sat, 28 Sep 2002 12:08:00 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:65040 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262061AbSI1QH7>; Sat, 28 Sep 2002 12:07:59 -0400
Date: Sat, 28 Sep 2002 18:13:16 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: sparc32 sunrpc.o
Message-ID: <20020928161316.GA4323@louise.pinerecords.com>
References: <mailman.1033072381.13688.linux-kernel2news@redhat.com> <200209262127.g8QLROv26197@devserv.devel.redhat.com> <20020926.142910.124086325.davem@redhat.com> <20020928122817.GV27082@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020928122817.GV27082@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >    From: Pete Zaitcev <zaitcev@redhat.com>
> >    Date: Thu, 26 Sep 2002 17:27:24 -0400
> > 
> >    > Since 2.4.20-pre2 or 3, sunrpc.o has had this problem on sparc32:
> >    > 
> >    > depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre8/kernel/net/sunrpc/sunrpc.o
> >    > depmod:         ___illegal_use_of_BTFIXUP_SETHI_in_module
> >    > depmod:         ___f_set_pte
> >    > depmod:         fix_kmap_begin
> >    > depmod:         ___f_flush_cache_all
> >    > depmod:         ___f_pte_clear
> >    > depmod:         ___f_mk_pte
> >    > depmod:         ___f_flush_tlb_all
> >    
> >    Try these two things:
> >    
> > No Peter, it really does use kmap_atomic stuff from modules, and this
> > precludes providing those routines inline in highmem.h, they must
> > live statically in main kernel image so that flush/pte calls can
> > be properly BTFIXUP'd.
> > 
> > See my other email.
> 
> Ok, DaveM, could you have a look at this patch?

Please disregard, highmem.c unreasonably included linux/highmem.h.
I'll be looking into this some more.

T.
