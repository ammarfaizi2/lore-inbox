Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTLAII5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 03:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTLAII5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 03:08:57 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:6869 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262052AbTLAIIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 03:08:55 -0500
Message-ID: <3FCAF5CC.9090700@cyberone.com.au>
Date: Mon, 01 Dec 2003 19:03:24 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Suman Puthana <suman@broadware.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: problem with iowait (disk I/O) in 2.4.21 kernel
References: <003c01c3b7de$b2f02090$04740718@vaiors410>
In-Reply-To: <003c01c3b7de$b2f02090$04740718@vaiors410>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Suman Puthana wrote:

>Hello,
>
>Is anybody aware of any changes in the 2.4.21 kernel which affects disk I/O
>badly?  We are noticing that the cpu taken up by iowait's is causing
>significant degradation in disk performance.
>
>We have an application in which there are multiple processes writing to disk
>simultaneously, each process writing anywhere from 16 - 64 K Bytes at a time
>and sleeping for about 50 ms depending on how long the write() call takes to
>finish. It is important that the write() finishes within 50 ms for this
>application. The file's are opened with the open() call with the standard
>O_RDWR and O_CREAT flags.
>
>On the 2.4.18 kernel, 25 of these processes take up about 15% of CPU on a
>dual Xeon Pentium 4 2.4 GHz processor with 1 MB of memory for a total
>throughput of about 7 MBps which is very good.  The write() calls typically
>take less than 5 ms to complete and we sleep for the remaining 45 ms or so.
>
>But on the same system when we installed the 2.4.21 kernel, these 25
>processes take anywhere between 40 - 70 % of the CPU depending on how  much
>CPU the iowait is taking up. The iowait part of it varies all the way from
>10 - 60 %. (The iowait CPU is within 1% on the 2.4.18 kernel.).  What is
>even worse - sometimes the write() calls take anywhere between 1 - 2
>seconds( yes seconds!) to return, which degrades the performance of our
>application server pretty badly.
>
> It happens on all kinds of storage devices so it's definitely not a
>hardware problem.(We tested on the standard IDE disk all the way upto the
>EMC clariion storage system).
>
>Is this iowait something which was introduced in the 2.4.21 kernel core code
>or in the file system driver code? It definitely happens with jfs, reiserfs
>and also on ext3 though not as badly . Is there a way to turn it off or to
>make it take up lesser CPU?
>
>Any insight or pointers regarding this problem would be greatly
>appreciated.  Thank you for your support.
>

Does this happen with 2.4.23? If yes, then can you find the last kernel
with good performance (is it 2.4.18, 19 or 20)?

Can you make the source code of this program available or make available
a minimal program with which you can reproduce the bad behaviour?

Thanks,
Nick


