Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWHUCqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWHUCqm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 22:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWHUCqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 22:46:42 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:49062 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932392AbWHUCql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 22:46:41 -0400
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Magnus Damm <magnus@valinux.co.jp>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrey Savochkin <saw@sw.ru>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Kirill Korotaev <dev@sw.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1155912348.9274.83.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
	 <1155755069.24077.392.camel@localhost.localdomain>
	 <1155756170.22595.109.camel@galaxy.corp.google.com>
	 <44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>
	 <20060818120809.B11407@castle.nmd.msu.ru>
	 <1155912348.9274.83.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 11:47:06 +0900
Message-Id: <1156128426.21411.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 07:45 -0700, Dave Hansen wrote:
> On Fri, 2006-08-18 at 12:08 +0400, Andrey Savochkin wrote:
> > 
> > A) Have separate memory management for each container,
> >    with separate buddy allocator, lru lists, page replacement mechanism.
> >    That implies a considerable overhead, and the main challenge there
> >    is sharing of pages between these separate memory managers.
> 
> Hold on here for just a sec...
> 
> It is quite possible to do memory management aimed at one container
> while that container's memory still participates in the main VM.  
> 
> There is overhead here, as the LRU scanning mechanisms get less
> efficient, but I'd rather pay a penalty at LRU scanning time than divide
> up the VM, or coarsely start failing allocations.

This could of course be solved with one LRU per container, which is how
the CKRM memory controller implemented things about a year ago.

/ magnus

