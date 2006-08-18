Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWHROkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWHROkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWHROkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:40:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24704 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030430AbWHROkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:40:09 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel
	memory	accounting	(core)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kirill Korotaev <dev@sw.ru>
Cc: rohitseth@google.com, Dave Hansen <haveblue@us.ibm.com>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <44E57FB4.8090905@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
	 <1155835003.14617.45.camel@galaxy.corp.google.com> <44E57FB4.8090905@sw.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 15:59:25 +0100
Message-Id: <1155913165.28764.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 12:52 +0400, ysgrifennodd Kirill Korotaev:
> > hmm, not sure why it is simpler.
> because introducing additonal lookups/hashes etc. is harder and
> adds another source for possible mistakes.
> we can always optimize it out if people insist (by cost of slower accounting).

It ought to be cheap. Given each set of page structs is an array its a
simple subtract and divide (or with care and people try to pack them
nicely for cache lines - shift) to get to the parallel accounting array.

Alan

