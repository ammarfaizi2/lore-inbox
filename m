Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWHVBSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWHVBSA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 21:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWHVBSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 21:18:00 -0400
Received: from smtp-out.google.com ([216.239.45.12]:4188 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751049AbWHVBR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 21:17:59 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=d1d9hGvyCkK3HY8IzsNKwHzjraoS2UmzrmtnY3Iy0w1X625LiRAGIffgzCIC9UBe7
	sGSBc/PsRaIP5ypoiUZwA==
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Magnus Damm <magnus@valinux.co.jp>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrey Savochkin <saw@sw.ru>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Kirill Korotaev <dev@sw.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156128426.21411.41.camel@localhost>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
	 <1155755069.24077.392.camel@localhost.localdomain>
	 <1155756170.22595.109.camel@galaxy.corp.google.com>
	 <44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>
	 <20060818120809.B11407@castle.nmd.msu.ru>
	 <1155912348.9274.83.camel@localhost.localdomain>
	 <1156128426.21411.41.camel@localhost>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 21 Aug 2006 18:16:19 -0700
Message-Id: <1156209379.11127.15.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 11:47 +0900, Magnus Damm wrote:
> On Fri, 2006-08-18 at 07:45 -0700, Dave Hansen wrote:
> > On Fri, 2006-08-18 at 12:08 +0400, Andrey Savochkin wrote:
> > > 
> > > A) Have separate memory management for each container,
> > >    with separate buddy allocator, lru lists, page replacement mechanism.
> > >    That implies a considerable overhead, and the main challenge there
> > >    is sharing of pages between these separate memory managers.
> > 
> > Hold on here for just a sec...
> > 
> > It is quite possible to do memory management aimed at one container
> > while that container's memory still participates in the main VM.  
> > 
> > There is overhead here, as the LRU scanning mechanisms get less
> > efficient, but I'd rather pay a penalty at LRU scanning time than divide
> > up the VM, or coarsely start failing allocations.
> 
> This could of course be solved with one LRU per container, which is how
> the CKRM memory controller implemented things about a year ago.

Effectively Andrew's idea of faking up nodes is also giving per
container LRUs.

-rohit 

