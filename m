Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUFFOtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUFFOtM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 10:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUFFOtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 10:49:12 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:56492 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S263713AbUFFOtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 10:49:09 -0400
Message-ID: <40C33F2D.3050408@codeweavers.com>
Date: Mon, 07 Jun 2004 00:58:37 +0900
From: Mike McCormack <mike@codeweavers.com>
Organization: Codeweavers
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Christoph Hellwig <hch@infradead.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <40C2B51C.9030203@codeweavers.com>	 <20040606073241.GA6214@infradead.org>  <40C2E045.8090708@codeweavers.com> <1086521938.4862.25.camel@localhost.localdomain>
In-Reply-To: <1086521938.4862.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Woodhouse wrote:

> Actually doesn't a kernel space loader let you discard text pages and
> fix them up again on demand as Windows does, rather than doing the
> relocations at load time and then having the pages considered dirty so
> they have to be swapped instead of just discarded? 

Yes, that would be one advantage of having a PE loader in the kernel. 
David Howells of Redhat was working on a kernel module that implemented 
all of the wineserver functionality, including a PE loader a while back. 
  Unfortunately that effort did not get anywhere. The code is still at:

http://cvs.winehq.com/cvsweb/kernel-win32

If there were a PE/COFF binary format handler in the kernel, it would 
still be able to load ELF executables, as Wine requires glibc, X11, etc.

Mike

