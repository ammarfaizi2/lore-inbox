Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSHZLRk>; Mon, 26 Aug 2002 07:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSHZLRk>; Mon, 26 Aug 2002 07:17:40 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:1550 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318040AbSHZLRk>; Mon, 26 Aug 2002 07:17:40 -0400
Date: Mon, 26 Aug 2002 12:21:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: dank@kegel.com
Cc: linux-kernel@vger.kernel.org, dank@alumni.caltech.edu
Subject: Re: [PATCH] khttpd crash fix, take 3
Message-ID: <20020826122155.A25069@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, dank@kegel.com,
	linux-kernel@vger.kernel.org, dank@alumni.caltech.edu
References: <200208260329.g7Q3T8h16233@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208260329.g7Q3T8h16233@kegel.com>; from dank@kegel.com on Sun, Aug 25, 2002 at 08:29:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 08:29:08PM -0700, dank@kegel.com wrote:
> 1. An oops in DecodeHeader where Buffer[CPUNR] is NULL, happened 
>    whenever a worker thread was restarted after being stopped.
>    (The worker thread frees its buffer on exit, but the manager thread
>     neglected to allocate a buffer for the worker thread when restarting it.)
> 2. A bug that caused worker threads to be spuriously restarted once
>    on startup (this made the previous bug much worse).
> 3. The end-user had to do a "sleep 1" after stopping the daemon
>    before restarting it.  This was not documented, and was rather confusing.
> 4. There was no entry in /usr/src/linux/Documentation for khttpd,
>    and beginning users sometimes could not find the documentation.

BTW: would you step up as khttpd maintainer? It seems no ones else cares for
it and it's always good to have someone to drop patches/complaints at..

