Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVDHXc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDHXc1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDHXc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:32:27 -0400
Received: from pat.uio.no ([129.240.130.16]:15350 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261198AbVDHXcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:32:22 -0400
Subject: Re: [RFC] Add support for semaphore-like structure with support
	for asynchronous I/O
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
In-Reply-To: <20050408223927.GA22217@kvack.org>
References: <1112224663.18019.39.camel@lade.trondhjem.org>
	 <1112309586.27458.19.camel@lade.trondhjem.org>
	 <20050331161350.0dc7d376.akpm@osdl.org>
	 <1112318537.11284.10.camel@lade.trondhjem.org>
	 <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com>
	 <20050404162216.GA18469@kvack.org>
	 <1112637395.10602.95.camel@lade.trondhjem.org>
	 <20050405154641.GA27279@kvack.org> <20050407114302.GA13363@infradead.org>
	 <20050408223927.GA22217@kvack.org>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 19:31:46 -0400
Message-Id: <1113003106.10596.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.684, required 12,
	autolearn=disabled, AWL 1.27, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 08.04.2005 Klokka 18:39 (-0400) skreiv Benjamin LaHaise:

> On the aio side of things, I introduced the owner field in the mutex (as 
> opposed to the flag in Trond's iosem) for the next patch in the series to 
> enable something like the following api:
> 
> 	int aio_lock_mutex(struct mutex *lock, struct iocb *iocb);

Any chance of a more generic interface too?

iocbs are fairly high level objects, and so I do not see them helping to
resolve low level filesystem problems such as the NFSv4 state cleanup.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

