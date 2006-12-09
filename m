Return-Path: <linux-kernel-owner+w=401wt.eu-S1760836AbWLINSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760836AbWLINSK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760847AbWLINSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:18:10 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47636 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760836AbWLINSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:18:07 -0500
Date: Sat, 9 Dec 2006 22:17:00 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org,
       akpm@osdl.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [2/4] generic
 virtual mem_map on sparsemem
Message-Id: <20061209221700.6feb2e5d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061209120547.GB10380@osiris.ibm.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160454.33fedd3f.kamezawa.hiroyu@jp.fujitsu.com>
	<20061209120547.GB10380@osiris.ibm.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 13:05:47 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> > +#if (((BITS_PER_LONG/4) * PAGES_PER_SECTION) % PAGE_SIZE) != 0
> > +#error "PAGE_SIZE/SECTION_SIZE relationship is not suitable for vmem_map"
> > +#endif
> 
> Why the BITS_PER_LONG/4? Or to put in other words: why not simply
> PAGES_PER_SECTION % PAGE_SIZE != 0 ?
> 
sorry, my mistake. What I wanted to do was

32bits arch --
4 * PAGES_PER_SECTION % PAGE_SIZE
64bits arch --
8 * PAGES_PER_SECTION % PAGE_SIZE

I'll renew this in the next week.

-Kame

