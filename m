Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbUFFLjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUFFLjx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 07:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUFFLjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 07:39:53 -0400
Received: from [213.146.154.40] ([213.146.154.40]:14529 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263365AbUFFLjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 07:39:51 -0400
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
From: David Woodhouse <dwmw2@infradead.org>
To: Mike McCormack <mike@codeweavers.com>
Cc: Christoph Hellwig <hch@infradead.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, dhowells@redhat.com
In-Reply-To: <40C2E045.8090708@codeweavers.com>
References: <40C2B51C.9030203@codeweavers.com>
	 <20040606073241.GA6214@infradead.org>  <40C2E045.8090708@codeweavers.com>
Content-Type: text/plain
Date: Sun, 06 Jun 2004 12:38:58 +0100
Message-Id: <1086521938.4862.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 18:13 +0900, Mike McCormack wrote:
> Christoph Hellwig wrote:
> 
> > if you have a need for a special virtual memory layout please use your
> > own binary loader as I already suggested earlier in the thread, i.e.
> > binfmt_pecoff.
> 
> We are using our own user space loader now, but a kernel space loader is 
>   neither portable or practical.

Actually doesn't a kernel space loader let you discard text pages and
fix them up again on demand as Windows does, rather than doing the
relocations at load time and then having the pages considered dirty so
they have to be swapped instead of just discarded? 

-- 
dwmw2

