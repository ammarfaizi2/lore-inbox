Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTB1Ajd>; Thu, 27 Feb 2003 19:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTB1Ajd>; Thu, 27 Feb 2003 19:39:33 -0500
Received: from packet.digeo.com ([12.110.80.53]:49547 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267310AbTB1Ajd>;
	Thu, 27 Feb 2003 19:39:33 -0500
Date: Thu, 27 Feb 2003 16:46:22 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, piggin@cyberone.com.au
Subject: Re: 2.5.63-mm1
Message-Id: <20030227164622.032d2ab8.akpm@digeo.com>
In-Reply-To: <200302271917.10139.tomlins@cam.org>
References: <20030227025900.1205425a.akpm@digeo.com>
	<200302271917.10139.tomlins@cam.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 00:49:46.0394 (UTC) FILETIME=[4A284FA0:01C2DEC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> On February 27, 2003 05:59 am, Andrew Morton wrote:
> > . Tons of changes to the anticipatory scheduler.  It may not be working
> >   very well at present.  Please use "elevator=deadline" if it causes
> >   problems.
> 
> The anticipatory scheduler hangs here at the same place it did in 62-mm2,
> cfq continues to work fine.  A sysrq+T of the hang follows:

I must say, Ed: you have an eerie ability to break stuff.

Please send me your .config.

>                          free                        sibling
>   task             PC    stack   pid father child younger older
> swapper       D DFF8FB20 11876     1      0     2               (L-TLB)

Interesting amount of free stack you have there.  You broke show_task() too!


