Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTJTBfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 21:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbTJTBfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 21:35:42 -0400
Received: from dyn-ctb-210-9-246-209.webone.com.au ([210.9.246.209]:11781 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262375AbTJTBfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 21:35:41 -0400
Message-ID: <3F933BE7.5080700@cyberone.com.au>
Date: Mon, 20 Oct 2003 11:35:35 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
References: <20031020003745.GA2794@rushmore>
In-Reply-To: <20031020003745.GA2794@rushmore>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



rwhron@earthlink.net wrote:

>There was about a 50% regression in jobs/minute in AIM7
>database workload on quad P3 Xeon.  The CPU time has not
>gone up, so the extra run time is coming from something
>else.  (I/O or I/O scheduler?)
>
>tiobench sequential reads has a significant regression too.
>
>Regression appears unrelated to filesystem type.
>
>dbench was not affected.
>
>The AIM7 was run on ext2.
>

Yeah I'd say its all due to the IO scheduler. There is a problem
I'm thinking about how to fix - its the likely cause of this too.


