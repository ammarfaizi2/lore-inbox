Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267651AbTAHCdJ>; Tue, 7 Jan 2003 21:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267669AbTAHCdJ>; Tue, 7 Jan 2003 21:33:09 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:19081 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S267651AbTAHCdH>; Tue, 7 Jan 2003 21:33:07 -0500
Message-ID: <3E1B907F.60008@didntduck.org>
Date: Tue, 07 Jan 2003 21:44:15 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Tinsley <btinsley@emageon.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: long stalls
References: <3E1B73F3.2070604@emageon.com>
In-Reply-To: <3E1B73F3.2070604@emageon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Tinsley wrote:

> We have been having terrible problems with long stalls, meaning from a
> couple of minutes to an hour, happening when filesystem I/O load gets
> high. The system time as reported by vmstat or sar will increase up to
> 99% and as it spreads to each procesor, the system becomes completely
> unresponsive (except that it responds to pings just fine -
> interesting!). When the system finally returns to the world of the
> living, the only evidence that something bad has happened is the runtime
> for kswapd is abnormally high. I have seen this happen with the stock
> 2.4.17, 2.4.19, and 2.4.20 kernels on SMP PIII and PIV machines (either
> 4GB or 8GB RAM, all SCSI disks, dual GigE NICs). I've searched the lkml
> archives and google and have found several similar postings, but there
> is never an explanation or resolution. Any help would be *very* much
> appreciated! If any info from the system in question is desired, I will
> be glad to provide it.
>
>
>
With 4GB of memory you are likely boucing I/O requests to low memory. 
This has been fixed in 2.5.  I do not know if a backport exists for 2.4.

--
				Brian Gerst

