Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUCLXHr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUCLXHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:07:46 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:6609 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263014AbUCLXHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:07:44 -0500
Message-ID: <40524251.5090702@cyberone.com.au>
Date: Sat, 13 Mar 2004 10:05:53 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <404FACF4.3030601@cyberone.com.au>	<200403111825.22674@WOLK>	<40517E47.3010909@cyberone.com.au>	<20040312012703.69f2bb9b.akpm@osdl.org>	<pan.2004.03.12.11.08.02.700169@smurf.noris.de>	<4051B0C6.2070302@cyberone.com.au>	<4051C5F1.2050605@cyberone.com.au>	<16465.53692.106520.847235@laputa.namesys.com>	<4051D737.1050108@cyberone.com.au> <16465.58851.227553.595591@laputa.namesys.com>
In-Reply-To: <16465.58851.227553.595591@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nikita Danilov wrote:

>Nick Piggin writes:
>
> > With my patch though, it gives unmapped pages the same treatment as
> > mapped pages. Without my patch, pages getting a lot of mark_page_accessed
> > activity can easily be promoted unfairly past mapped ones which are simply
> > getting activity through the pte.
>
>Another way to put it is that treatment of file system pages is dumbed
>down to the level of mapped ones: information about access patterns is
>just discarded.
>
>

In a way, yes.

> > 
> > I say just set the bit and let the scanner handle it.
>
>I think that decisions about balancing VM and file system caches should
>be done by higher level, rather than by forcing file system to use
>low-level mechanisms designed for VM, where only limited information is
>provided by hardware. Splitting page queues is a step in a right
>direction, as it allows to implement more precise replacement for the
>file system cache.
>
>

It makes it that much harder to calculate the pressure you are putting
on mapped vs unmapped pages though.

