Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317304AbSG1Uru>; Sun, 28 Jul 2002 16:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317315AbSG1Uru>; Sun, 28 Jul 2002 16:47:50 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:19468 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S317304AbSG1Uru>;
	Sun, 28 Jul 2002 16:47:50 -0400
Message-ID: <3D4459FF.1A98606C@tv-sign.ru>
Date: Mon, 29 Jul 2002 00:54:23 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] Thread-Local Storage (TLS) support for 
 Linux,2.5.28
References: <Pine.LNX.4.44.0207282207450.32536-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:
> 
> On Sun, 28 Jul 2002, Oleg Nesterov wrote:
> 
> > +      * Load the per-thread Thread-Local Storage descriptor.
> > +      *
> > +      * NOTE: it's faster to do the two stores unconditionally
> > +      * than to branch away.
> > +      */
> > +     load_TLS_desc(next, cpu);
> > +
> > +     /*
> >        * Save away %fs and %gs. No need to save %es and %ds, as
> 
> actually, shouldnt this be done after saving the current %fs and %gs, and
> before loading the next %fs and %gs?
> 
>         Ingo

Well, load_TLS() and saving current %fs,%gs are just mem stores, no?
I can't see any difference in terms of correctness.

Oleg.
