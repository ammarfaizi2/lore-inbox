Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVBCKs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVBCKs3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVBCKrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:47:52 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:50067 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262933AbVBCKrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:47:24 -0500
Subject: Re: 2.6.10: kswapd spins like crazy
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Terje =?ISO-8859-1?Q?F=E5berg?= <terje_fb@yahoo.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050203102915.61551.qmail@web51602.mail.yahoo.com>
References: <20050203102915.61551.qmail@web51602.mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 03 Feb 2005 21:47:09 +1100
Message-Id: <1107427629.5611.13.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 11:29 +0100, Terje Fåberg wrote:
> I recently upgraded my desktop from 2.4.28 to
> 2.6.10. Even under moderate memory pressure kswapd
> regularly eats almost all available cpu time 
> whenever there is a little more IO throughput,
> like copying large files. The system is extremely
> sluggish during this. The system load goes up to 
> 7.5 or more.
>  
> This is a Pentium3-866 with 768MB RAM, 2x1GB 
> swap partitions, vanilla 2.6.10. The strange 
> behaviour starts at about 200 MB of swap in use.
> 2.4.28 masters the same workload without any
> problems.
> 
> vmstat:
> procs -----------memory---------- 
>  r  b   swpd   free   buff  cache
>  6  1 428012   4868  33236 347184
> ---swap-- -----io---- --system-- ----cpu----
>  si   so    bi    bo   in    cs us sy id wa
>  10    7   147   120  108   111 19 10 68  3
> 
> Is there anything I can do to track this down?
> 

Can you post about 10 seconds of `vmstat 1` output
while this is happening?

Also:
`cat /proc/vmstat > pre ; sleep 10 ; cat /proc/vmstat > post`
while this is happening, and send the pre and post files.

cat /proc/meminfo also might be helpful.

And compile a kernel with "magic sysrq" support, and get a
couple of Alt+SysRq+M dumps (the output will be in dmesg).

Thanks,
Nick



