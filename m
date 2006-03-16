Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752164AbWCPGU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbWCPGU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 01:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbWCPGU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 01:20:59 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:45201 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752164AbWCPGU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 01:20:58 -0500
Date: Thu, 16 Mar 2006 15:22:06 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines
 for_each_possible_cpu
Message-Id: <20060316152206.7ac3bdb4.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4418E879.3000207@yahoo.com.au>
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>
	<4418DEEA.2000008@yahoo.com.au>
	<20060316131743.d7b716e9.kamezawa.hiroyu@jp.fujitsu.com>
	<4418E879.3000207@yahoo.com.au>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006 15:24:25 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> KAMEZAWA Hiroyuki wrote:
> > On Thu, 16 Mar 2006 14:43:38 +1100
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> > 
> >>The only places where things might care is arch bootup code, but
> >>the cpu interface is such that the arch code is expected to _hide_
> >>any weird details from these generic interfaces.
> >>
> > 
> > Please see i386 patch. it contains BUG fix.
> > cpu_msrs[i].coutners are allocated by for_each_online_cpu().
> > and free it by for_each_possible_cpus() without no pointer check.
> > 
> 
> Well that's another problem then, such a fix should not be sent in
> this patchset, but as a separate patch.
> 
Sorry. and It wasn't real problem as Yoshifuji said.
I'll send fix patch later.

> > I think this kind of confusion will be seen again in future.
> 
> I'm sure that renaming for_each_cpu would not prevent that either.
> 

But maintainers can check easily whether online or possible should be,
when they received a patch which includes for_each_cpu().

-- Kame 

