Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbVHSVfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbVHSVfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVHSVfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:35:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965173AbVHSVfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:35:17 -0400
Date: Fri, 19 Aug 2005 14:33:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] f_maxcount seems to be deprecated ?
Message-Id: <20050819143344.4a6c49b2.akpm@osdl.org>
In-Reply-To: <43064ED1.40805@cosmosbay.com>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	<1124467911.9329.11.camel@kleikamp.austin.ibm.com>
	<20050819122122.0852de3a.akpm@osdl.org>
	<43064ED1.40805@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Considering :
> 
> [root@dada1 linux-2.6.13-rc6]# find .|xargs grep f_maxcount
> ./fs/file_table.c:      f->f_maxcount = INT_MAX;
> ./fs/read_write.c:      if (unlikely(count > file->f_maxcount))
> ./include/linux/fs.h:   size_t                  f_maxcount;
> 
> 
> I was wondering if f_maxcount has a real use these days...

No, I guess we can just stick a hard-wired INT_MAX in there.

