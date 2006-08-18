Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWHROp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWHROp6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWHROp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:45:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:64457 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030444AbWHROp5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:45:57 -0400
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrey Savochkin <saw@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@sw.ru>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       devel@openvz.org, rohitseth@google.com, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <20060818120809.B11407@castle.nmd.msu.ru>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
	 <1155755069.24077.392.camel@localhost.localdomain>
	 <1155756170.22595.109.camel@galaxy.corp.google.com>
	 <44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>
	 <20060818120809.B11407@castle.nmd.msu.ru>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 07:45:48 -0700
Message-Id: <1155912348.9274.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 12:08 +0400, Andrey Savochkin wrote:
> 
> A) Have separate memory management for each container,
>    with separate buddy allocator, lru lists, page replacement mechanism.
>    That implies a considerable overhead, and the main challenge there
>    is sharing of pages between these separate memory managers.

Hold on here for just a sec...

It is quite possible to do memory management aimed at one container
while that container's memory still participates in the main VM.  

There is overhead here, as the LRU scanning mechanisms get less
efficient, but I'd rather pay a penalty at LRU scanning time than divide
up the VM, or coarsely start failing allocations.

-- Dave

