Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUB0Dht (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 22:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbUB0Dht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 22:37:49 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:41895 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261681AbUB0Dhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 22:37:45 -0500
Message-ID: <403EBB87.2070504@namesys.com>
Date: Fri, 27 Feb 2004 06:37:43 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: markw@osdl.org, piggin@cyberone.com.au, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: AS performance with reiser4 on 2.6.3
References: <200402261748.i1QHmJE12429@mail.osdl.org> <16446.13520.5837.193556@laputa.namesys.com>
In-Reply-To: <16446.13520.5837.193556@laputa.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>markw@osdl.org writes:
> > Hi Nick,
> > 
> > I started getting some results with dbt-2 on 2.6.3 and saw that reiser4
> > is doing a bit worse with the AS elevator.  Although reiser4 wasn't
> > doing well to begin with, compared to the other filesystems.  I have
> > links to the STP results on our 4-ways and 8-ways here:
> > 	http://developer.osdl.org/markw/fs/dbt2_stp_results.html
>
>There were no changes between 2.6.2 and 2.6.3 that could affect reiser4
>performance, so it is not clear why numbers are so different. Probably
>results should be averaged over several runs.
>
The differences don't "feel" like testing error, and in any event 
something is seriously wrong.  That something is either poor fsync 
performance, or poor scalability.  In any event, please investigate, and 
please try such things as using capture on copy.  Mark, does this 
benchmark like to use fsync?

Thanks much mark for bringing this to our attention.

> Also can you run test with
>
>http://www.namesys.com/snapshots/2004.02.25/extra/e_05-proc-sleep.patch
>
>applied? To use it turn CONFIG_PROC_SLEEP on (depends on
>CONFIG_FRAME_POINTER), and do "cat /proc/sleep" before and after test
>run.
>
> > 
> > -- 
> > Mark Wong - - markw@osdl.org
>
>Nikita.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans


