Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266396AbUAIAtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266394AbUAIAtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:49:46 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:41997 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266395AbUAIAtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:49:42 -0500
Date: Fri, 9 Jan 2004 01:49:34 +0100
From: Willy Tarreau <willy@w.ods.org>
To: u1_amd64@dslr.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: time cat /proc/*/statm ?
Message-ID: <20040109004934.GC545@alpha.home.local>
References: <179256560250.20040108135458@dslr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179256560250.20040108135458@dslr.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 01:54:58PM -0500, u1_amd64@dslr.net wrote:
> Is it reasonable for a 64bit dual cpu to take 5+ seconds of processing to
> cat /proc/*/statm when there is hardly more than 1gb of actual memory
> space used by processes (the rest being filesystem cache)?

Here on alpha, it takes 0.023s (0.011 sys) for 58 processes on 2.4.23.
Perhaps there's something specific to x86_64 ?

Willy

> # free
>              total       used       free     shared    buffers     cached
> Mem:      16278356   16264484      13872          0      85400   14819932
> -/+ buffers/cache:    1359152   14919204
> 
> # ps -eda|wc
>  216     866    6751
> 
> # time cat /proc/*/statm
> :
> :
> :
> real    0m5.740s
> user    0m0.003s
> sys     0m5.521s
> 
> # uname -a
> 
> Linux silver 2.4.21-151-smp #22 SMP Mon Jan 5 21:31:07 PST 2004 x86_64 x86_64 x86_64 GNU/Linux
> 
> 
> thanks!!
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
