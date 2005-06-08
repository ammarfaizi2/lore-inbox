Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVFHENb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVFHENb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 00:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVFHENb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 00:13:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:4499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262083AbVFHENZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 00:13:25 -0400
Date: Tue, 7 Jun 2005 21:13:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: dan.dickey@savvis.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: System state too high for too long...
Message-Id: <20050607211310.7f6ee27e.akpm@osdl.org>
In-Reply-To: <200506071125.41543.dan.dickey@savvis.net>
References: <200506071125.41543.dan.dickey@savvis.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dan A. Dickey" <dan.dickey@savvis.net> wrote:
>
> This problem has now been persistent enough in the last few kernels
>  I've run that I've subscribed (once again) to the linux-kernel list
>  and would like to report it.
>  I'm using gentoo-sources-2.6.11-r9.
> 
>  When the system is compiling something, the state typically
>  stays at about 85-95% system time.  This just really does not
>  seem right for my workload, and additionally only appeared
>  a few releases ago (sorry, I didn't bother to track it - I thought
>  it might go away in a release or two; but it has not).
> 
>  Here is a little output of 'vmstat 5' when this is happening:
>  procs -----------memory---------- ---swap-- -----io---- --system-- 
>  ----cpu----
>   r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
>  sy id wa
>   1  0  12752  61548  57252 211092    0    0     2    50 1083   810 11 
>  89  0  0
>   1  0  12752  57572  57320 211160    0    0     0    63 1089   683  9 
>  91  0  0
>   1  0  12752  63288  57328 211220    0    0     8    39 1084   765 11 
>  89  0  0
>   1  0  12752  60648  57348 211200    0    0     0    56 1086   647  6 
>  94  0  0
>   1  0  12752  54972  57348 211200    0    0     0     3 1079   659  8 
>  92  0  0
>   1  0  12752  62284  57348 211268    0    0     4    53 1087   807 17 
>  83  0  0
>   1  0  12752  59400  57356 211328    0    0     0    34 1222  1919 17 
>  83  0  0

(grr, wordwrapping.)

- Check that your disks are running in DMA mode (if they're IDE) (with hdparm)

- See what `time make' says

- Generate a kernel profile (See Documentation/basic_profiling.txt)


