Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTHYHQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 03:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbTHYHQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 03:16:30 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:58005 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261528AbTHYHQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 03:16:29 -0400
Date: Mon, 25 Aug 2003 16:17:15 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: cache limit
In-reply-to: <3F449674.2040102@softhome.net>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <CC36AD8E91352indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.04 (WinNT,501)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
References: <3F449674.2040102@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for interest in my patch.

On Thu, 21 Aug 2003 11:52:52 +0200, Ihar 'Philips' Filipau wrote:

>Takao Indoh wrote:
>> 
>> I made a patch to add new paramter /proc/sys/vm/pgcache-max. It controls
>> maximum number of pages used as pagecache.
>> An attached file is a mere test patch, so it may contain a bug or ugly
>> code. Please let me know if there is an advice, comment, better
>> implementation, and so on.
>> 
>
>   Do you have something like this for 2.4 kernels?

No, I have only a patch for 2.5 kernel.
But, RedHat AdvancedServer2.1(2.4.9based kernel) has a similar parameter
(/proc/sys/vm/pagecache). If you can see the source, please check it.

>
>   [ I expected to find that by default Linux stops polluting memory 
>with cache when there is no more pages. But as I see your patch is 
>hacking something somewhere in the middle... But I'm not a specialist in 
>VM... Gone reading sources. ]
>
>   Thanks for the patch.

I'm not a specialist in VM, too. So, that patch may have many bugs.
What is done in that patch is very simple.
1) Add PG_pgcache flag to the page used as pagecache.
2) Watch the total amount of pagecahe.
3) If the amount of pagecahe exceeds maximum,
   try to remove only the page which has PG_pgcache flag.

Thanks.
--------------------------------------------------
Takao Indoh
 E-Mail : indou.takao@soft.fujitsu.com
