Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbVKBMnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbVKBMnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 07:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVKBMnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 07:43:06 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:49645 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932675AbVKBMnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 07:43:05 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Dave Hansen <haveblue@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gerrit Huizenga <gh@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20051102120048.GA10081@elte.hu>
References: <20051102104131.GA7780@elte.hu>
	 <E1EXGPs-0006JA-00@w-gerrit.beaverton.ibm.com>
	 <20051102120048.GA10081@elte.hu>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 13:42:49 +0100
Message-Id: <1130935369.15627.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 13:00 +0100, Ingo Molnar wrote:
> 
> >  Yeah - and that isn't what is being proposed here.  The goal is to 
> >  ask the kernel to identify some memory which can be legitimately 
> >  freed and hasten the freeing of that memory.
> 
> but that's very easy to identify: check the free list or the clean 
> list(s). No defragmentation necessary. [unless the unit of RAM mapping 
> between hypervisor and guest is too coarse (i.e. not 4K pages).]

It needs to be that coarse in cases where HugeTLB is desired for use.
I'm not sure I could convince the DB guys to give up large pages,
they're pretty hooked on them. ;)

-- Dave

