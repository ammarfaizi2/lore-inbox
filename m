Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWHQRTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWHQRTb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWHQRTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:19:31 -0400
Received: from smtp-out.google.com ([216.239.45.12]:49825 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030185AbWHQRTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:19:30 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=TKWEnhXbc9tzQqxiA8meuY4BP6bmcf8hYtq959reml2lxIwjqYDlcQll8Wl7nDNAw
	HAqe4kyvraGhT+hFfxpaw==
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1155824788.9274.32.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 17 Aug 2006 10:16:43 -0700
Message-Id: <1155835003.14617.45.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 07:26 -0700, Dave Hansen wrote:
> On Thu, 2006-08-17 at 01:24 +0100, Alan Cox wrote:
> > Ar Mer, 2006-08-16 am 12:59 -0700, ysgrifennodd Dave Hansen:
> > > relationship between processes and mm's.  We could also potentially have
> > > two different threads of a process in two different accounting contexts.
> > > But, that might be as simple to fix as disallowing things that share mms
> > > from being in different accounting contexts, unless you unshare the mm.
> > 
> > At the point I have twenty containers containing 20 copies of glibc to
> > meet your suggestion it would be *far* cheaper to put it in the page
> > struct.
> 
> My main thought is that _everybody_ is going to have to live with the
> entry in the 'struct page'.  Distros ship one kernel for everybody, and
> the cost will be paid by those not even using any kind of resource
> control or containers.
> 
> That said, it sure is simpler to implement, so I'm all for it!


hmm, not sure why it is simpler.

-rohit

