Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWHYULh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWHYULh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWHYULh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:11:37 -0400
Received: from pat.uio.no ([129.240.10.4]:64712 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964918AbWHYULg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:11:36 -0400
Subject: Re: [PATCH 7/6] Lost bits - fix PG_writeback vs PG_private race in
	NFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>
In-Reply-To: <1156523815.16027.43.camel@taijtu>
References: <20060825153709.24254.28118.sendpatchset@twins>
	 <1156523815.16027.43.camel@taijtu>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 16:11:27 -0400
Message-Id: <1156536687.5927.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.148, required 12,
	autolearn=disabled, AWL 1.85, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 18:36 +0200, Peter Zijlstra wrote:
> Make sure we clear PG_writeback after we clear PG_private, otherwise
> weird and wonderfull stuff will happen.
> 
NACK.

Look carefully at the case of unstable writes: your patch does nothing
to guarantee that PG_writeback is cleared after PG_private for that
case.
Anyhow, you don't explain exactly what is wrong with clearing
PG_writeback before PG_private.

Cheers,
  Trond

