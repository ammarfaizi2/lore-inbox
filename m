Return-Path: <linux-kernel-owner+w=401wt.eu-S1756344AbWLIDif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbWLIDif (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 22:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756336AbWLIDie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 22:38:34 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:35110 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbWLIDie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 22:38:34 -0500
Date: Sat, 9 Dec 2006 12:41:41 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [3/4] static
 virtual mem_map
Message-Id: <20061209124141.a945854d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061208193323.8c5382c6.akpm@osdl.org>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160708.c263a393.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208163020.4650bbaa.akpm@osdl.org>
	<20061209114950.307d57ca.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208193323.8c5382c6.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 19:33:23 -0800
Andrew Morton <akpm@osdl.org> wrote:

> > 
> > > Would prefer to unconditionally include the header file - conditional inclusions
> > > like this can cause compile failures when someone changes a config option.  They
> > > generally raise the complexity level.
> > >
> > Okay.
> > Now, forward declearation of 'struct page' is in mmzone.h. 
> > I'll remove it and include mm_types.h instead of it.
> > If someone says "Don't do that", I'll look for anothere way.
> > 
> 
> This header needs mm_types.h, so including it is certainly OK - there's no
> choice.  But I think it'd be better to include mm_types.h outside of any
> ifdefs.  Just stick the #include at the start of the file as usual.
> 
Okay, I'll make clean up patch in that way.

Thanks,
-Kame

