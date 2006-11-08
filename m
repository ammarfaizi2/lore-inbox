Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754514AbWKHKw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbWKHKw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbWKHKw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:52:57 -0500
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:63897 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1754511AbWKHKw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:52:56 -0500
Subject: Re: [PATCH 0/1] mspec driver: compile error
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Jes Sorensen <jes@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Robin Holt <holt@sgi.com>, Dean Nelson <dcn@sgi.com>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       Tony Luck <tony.luck@gmail.com>
In-Reply-To: <4551B1ED.2000405@sgi.com>
References: <1162881017.13700.105.camel@sebastian.intellilink.co.jp>
	 <4550609A.7010908@sgi.com>	<20061107133512.a49b11e0.akpm@osdl.org>
	 <1162977589.7805.77.camel@sebastian.intellilink.co.jp>
	 <4551A66A.2070506@sgi.com>
	 <1162979130.7805.80.camel@sebastian.intellilink.co.jp>
	 <20061108015618.571242fb.akpm@osdl.org>  <4551B1ED.2000405@sgi.com>
Content-Type: text/plain; charset=utf-8
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Wed, 08 Nov 2006 19:52:54 +0900
Message-Id: <1162983174.3054.43.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006-11-08 (水) の 11:31 +0100 に Jes Sorensen さんは書きました:
> Andrew Morton wrote:
> > On Wed, 08 Nov 2006 18:45:30 +0900
> > Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp> wrote:
> >> On Wed, 2006-11-08 at 10:42 +0100, Jes Sorensen wrote:
> >>> Given that MSPEC is clearly marked as depending on IA64, it seems bogus
> >>> for i386 allmodconfig to barf over it and the problem should be fixed
> >>> there instead IMHO.
> >> Agreed. That is why I asked if that was allmodconfig's expected
> >> behaviour. Andrew?
> > 
> > kconfig's `select' isn't very smart.  This is one of the reasons why one
> > should avoid using it.
> 
> Hmmm, so what do we do? I really don't like the idea that one has to
> manually select the uncached allocator in order for mspec to be
> available.
> 
> Alternatively can move the Kconfig field for MSPEC to arch/ia64/Kconfig,
> but that seems a bit dodgy too.
The whole thing could be considered an "allmodconfig" bug. In this case,
"select" is working as expected on IA64 and automatically sets
IA64_UNCACHED_ALLOCATOR when MSPEC is selected.

Perhaps the right fix would be modifying allmodconfig so that it takes
into account dependecies (i.e. "depends on", "select", etc).

