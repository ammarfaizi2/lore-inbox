Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269152AbUIYApQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269152AbUIYApQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 20:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269153AbUIYApQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 20:45:16 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:41614 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269152AbUIYApM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 20:45:12 -0400
Message-ID: <4154BF8F.9070904@yahoo.com.au>
Date: Sat, 25 Sep 2004 10:45:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Steven Pratt <slpratt@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <4152F46D.1060200@austin.ibm.com>	<20040923194216.1f2b7b05.akpm@osdl.org>	<41543FE2.5040807@austin.ibm.com> <20040924150523.4853465b.akpm@osdl.org>
In-Reply-To: <20040924150523.4853465b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Steven Pratt <slpratt@austin.ibm.com> wrote:

>>Can you expand on the POSIX_FADV_WILLNEED.
> 
> 
> It's an application-specified readahead hint.  It should ideally be
> asynchronous so the application can get some I/O underway while it's
> crunching on something else.  If the queue is contested then the
> application will accidentally block when launching the readahead, which
> kinda defeats the purpose.
> 
> Yes, the application will block when it does the subsequent read() anyway,
> but applications expect to block in read().  Seems saner this way.

Good point. I guess you're right.
