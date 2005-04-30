Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVD3QvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVD3QvE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVD3QvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:51:04 -0400
Received: from pat.uio.no ([129.240.130.16]:60846 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261294AbVD3Quh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:50:37 -0400
Subject: Re: [RFC] unify semaphore implementations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <17010.58405.906123.715001@cargo.ozlabs.ibm.com>
References: <20050428182926.GC16545@kvack.org>
	 <17009.33633.378204.859486@cargo.ozlabs.ibm.com>
	 <20050429141437.GA24617@kvack.org>
	 <17010.58405.906123.715001@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 30 Apr 2005 12:50:16 -0400
Message-Id: <1114879817.14213.25.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.541, required 12,
	autolearn=disabled, AWL 1.41, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On lau , 2005-04-30 at 11:49 +1000, Paul Mackerras wrote:
> Benjamin LaHaise writes:
> 
> > There are at least two users who need asynchronous semaphore/mutex 
> > operations: aio_write (which needs to acquire i_sem), and nfs.  
> 
> What do you mean by asynchronous semaphore/mutex operations?  Are you
> talking about a down operation that will acquire the semaphore if it
> is free, but if not, arrange for a callback and return immediately, or
> something?

Yes. See the iosem patches I posted a couple of weeks ago.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

