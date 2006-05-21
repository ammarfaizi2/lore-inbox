Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWEUMiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWEUMiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 08:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWEUMiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 08:38:25 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:18693 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750964AbWEUMiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 08:38:24 -0400
Message-ID: <44705F38.10905@argo.co.il>
Date: Sun, 21 May 2006 15:38:16 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: Renzo Davoli <renzo@cs.unibo.it>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Daniel Jacobowitz <dan@debian.org>,
       Ulrich Drepper <drepper@gmail.com>, osd@cs.unibo.it,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
References: <20060518155337.GA17498@cs.unibo.it> <20060519174534.GA22346@cs.unibo.it> <20060519201509.GA13477@nevyn.them.org> <200605192217.30518.ak@suse.de> <1148135825.2085.33.camel@localhost.localdomain> <20060520183020.GC11648@cs.unibo.it> <20060520213959.GA4229@ccure.user-mode-linux.org>
In-Reply-To: <20060520213959.GA4229@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2006 12:38:18.0423 (UTC) FILETIME=[6FEAA470:01C67CD3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
>> PTRACE_MULTI can be also used to optimize many other virtualized calls,
>> e.g. to read/write all the buffers for a readv/writev/recvmsg/sendmsg
>> call at once.
>>     
>
> Here, I bet the data copying cost dominates the system call, and the
> syscall overhead is minimal.	

In addition, the aio API allows you to do that in two calls for an iovec 
of any size.

-- 
error compiling committee.c: too many arguments to function

