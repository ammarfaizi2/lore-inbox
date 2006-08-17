Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWHQNZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWHQNZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWHQNZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:25:27 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:47794 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932492AbWHQNZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:25:26 -0400
Message-ID: <44E46ED3.7000201@sw.ru>
Date: Thu, 17 Aug 2006 17:27:47 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru> <1155752693.22595.76.camel@galaxy.corp.google.com>
In-Reply-To: <1155752693.22595.76.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I'm reading this patch right then seems like you are making page
> allocations to fail w/o (for example) trying to purge some pages from
> the page cache belonging to this container.  Or is that reclaim going to
> come later?

charged kernel objects can't be _reclaimed_. how do you propose
to reclaim tasks page tables or files or task struct or vma or etc.?

Kirill

