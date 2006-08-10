Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbWHJIDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWHJIDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbWHJIDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:03:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161111AbWHJIDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:03:38 -0400
Date: Thu, 10 Aug 2006 01:02:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take6 1/3] kevent: Core files.
Message-Id: <20060810010254.3b52682f.akpm@osdl.org>
In-Reply-To: <20060810075047.GB24370@2ka.mipt.ru>
References: <11551105592821@2ka.mipt.ru>
	<11551105602734@2ka.mipt.ru>
	<20060809152127.481fb346.akpm@osdl.org>
	<20060810061433.GA4689@2ka.mipt.ru>
	<20060810001844.ff5e7429.akpm@osdl.org>
	<20060810075047.GB24370@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 11:50:47 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> > Afaict this mmap function gives a user a free way of getting pinned memory. 
> > What is the upper bound on the amount of memory which a user can thus
> > obtain?
> 
> it is limited by maximum queue length which is 4k entries right now, so
> maximum number of paged here is 4k*40/page_size, i.e. about 40 pages on
> x86.

Is that per user or per fd?  If the latter that is, with the usual
RLIMIT_NOFILE, 160MBytes.  2GB with 64k pagesize.  Problem ;)

