Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbTDVO6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbTDVO6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:58:22 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55475 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263190AbTDVO6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:58:19 -0400
Date: Tue, 22 Apr 2003 11:09:53 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       <mingo@elte.hu>, <hugh@veritas.com>, <dmccr@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <171070000.1051021955@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0304221108090.10400-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Martin J. Bligh wrote:

> Oh, BTW. You're assuming no sharing of any pages in the above. Look what
> happens if 1000 processes share the same page ...

i'm not assuming anything - this is the per-process overhead.

processes have well-known RAM overhead associated to the size (and
fragmentation) of their virtual memory space, primarily caused by
pagetables. My suggestion triples this cost [where pte chains double the
costs], but leaves the scaling factor and generic characteristics the
same.

	Ingo

