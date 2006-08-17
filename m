Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWHQO1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWHQO1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWHQO1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:27:22 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:4743 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965028AbWHQO1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:27:20 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1155774274.15195.3.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 07:26:28 -0700
Message-Id: <1155824788.9274.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 01:24 +0100, Alan Cox wrote:
> Ar Mer, 2006-08-16 am 12:59 -0700, ysgrifennodd Dave Hansen:
> > relationship between processes and mm's.  We could also potentially have
> > two different threads of a process in two different accounting contexts.
> > But, that might be as simple to fix as disallowing things that share mms
> > from being in different accounting contexts, unless you unshare the mm.
> 
> At the point I have twenty containers containing 20 copies of glibc to
> meet your suggestion it would be *far* cheaper to put it in the page
> struct.

My main thought is that _everybody_ is going to have to live with the
entry in the 'struct page'.  Distros ship one kernel for everybody, and
the cost will be paid by those not even using any kind of resource
control or containers.

That said, it sure is simpler to implement, so I'm all for it!

-- Dave

