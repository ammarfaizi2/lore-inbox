Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbSLNTNC>; Sat, 14 Dec 2002 14:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265830AbSLNTNC>; Sat, 14 Dec 2002 14:13:02 -0500
Received: from angband.namesys.com ([212.16.7.85]:5505 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265828AbSLNTNB>; Sat, 14 Dec 2002 14:13:01 -0500
Date: Sat, 14 Dec 2002 22:20:53 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large writes
Message-ID: <20021214222053.A10506@namesys.com>
References: <3DFA2D4F.3010301@namesys.com> <3DFA53DA.DE6788C1@digeo.com> <20021214162108.A3452@namesys.com> <3DFB7B9E.FC404B6B@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3DFB7B9E.FC404B6B@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Dec 14, 2002 at 10:42:38AM -0800, Andrew Morton wrote:
> > Find below the patch that address all the issues you've brought.
> > It is on top of previous one.
> > Do you think it is ok now?
> I addresses the things I noticed and raised, thanks.  Except for the
> stack-space use.  People are waving around 4k-stack patches, and we
> do need to be careful there.

Well, 450 bytes is way below 4k (~7 times less if we'd take task struct
into account) ;)
I can replace that on-stack array with kmalloc, but that probably
would be a lot of overhead for no benefit.
What do you think is safe stack usage limit for a function?
(and btw you have not even seen reiser4 stack usage ;) )

Bye,
    Oleg
