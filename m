Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262979AbSJJC7l>; Wed, 9 Oct 2002 22:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262977AbSJJC7l>; Wed, 9 Oct 2002 22:59:41 -0400
Received: from packet.digeo.com ([12.110.80.53]:9631 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262979AbSJJC7j>;
	Wed, 9 Oct 2002 22:59:39 -0400
Message-ID: <3DA4EE6C.6B4184CC@digeo.com>
Date: Wed, 09 Oct 2002 20:05:16 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DA4D3E4.6080401@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2002 03:05:17.0333 (UTC) FILETIME=[DC546450:01C27009]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> 
> Greetings & Salutations,
>         Here's a wonderful patch that I know you're all dying for...  Memory
> Binding!


Seems reasonable to me.

Could you tell us a bit about the operator's view of this?

I assume that a typical usage scenario would be to bind a process
to a bunch of CPUs and to then bind that process to a bunch of
memblks as well? 

If so, then how does the operator know how to identify those
memblks?  To perform the (cpu list) <-> (memblk list) mapping?

Also, what advantage does this provide over the current node-local
allocation policy?  I'd have thought that once you'd bound a 
process to a CPU (or to a node's CPUs) that as long as the zone
fallback list was right, that process would be getting local memory
pretty much all the time anyway?

Last but not least: you got some benchmark numbers for this?

Thanks.
