Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVCaPA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVCaPA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVCaPA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:00:56 -0500
Received: from pat.uio.no ([129.240.130.16]:35002 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261488AbVCaPAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:00:33 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050331145439.GA4896@elte.hu>
References: <1112237239.26732.8.camel@mindpipe>
	 <1112240918.10975.4.camel@lade.trondhjem.org>
	 <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org>
	 <20050331073017.GA16577@elte.hu>
	 <1112270304.10975.41.camel@lade.trondhjem.org>
	 <1112272451.10975.72.camel@lade.trondhjem.org>
	 <20050331135825.GA2214@elte.hu>
	 <1112279522.20211.8.camel@lade.trondhjem.org>
	 <20050331143930.GA4032@elte.hu>  <20050331145439.GA4896@elte.hu>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 10:00:17 -0500
Message-Id: <1112281217.20211.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.567, required 12,
	autolearn=disabled, AWL 1.38, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 31.03.2005 Klokka 16:54 (+0200) skreiv Ingo Molnar:

> i think it's incorrect in its current form, because 'pos' is not 
> necessarily safe and might be removed from the commit_list?

Right.

> the whole loop could be a "while (!list_empty(head))" thing, if it wasnt 
> for the possibility for an nfs_set_page_writeback_locked() to skip an 
> entry. Maybe a local list of 'already processed' requests should be 
> built, and once the main list is emptied, moved back into the main list? 
> Then the lock-break could be moved to the end of the loop.

Should be pretty much unnecessary. See my previous email.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

