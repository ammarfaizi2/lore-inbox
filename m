Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVEDLxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVEDLxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 07:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVEDLxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 07:53:20 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:55338 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261641AbVEDLw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 07:52:27 -0400
Message-ID: <4278B772.5080806@sw.ru>
Date: Wed, 04 May 2005 15:52:18 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Carlos Carvalho <carlos@fisica.ufpr.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: problem with nice values and cpu consumption in 2.6.11-5
References: <17015.35256.12650.37887@fisica.ufpr.br>
In-Reply-To: <17015.35256.12650.37887@fisica.ufpr.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a real problem with O(1)-scheduler in 2.6... :(
The only workaround for you right now is to run 2.4 or move to some type 
of virtualization solutions with fair cpu scheduler...

Kirill

> Look at this cpu usage in a two-processor machine:
> 
>   893 user1   39  19  7212 5892  492 R 99.7  1.1   3694:29 mi41
>  1118 user2   25   0  155m  61m  624 R 50.0 12.3 857:54.18 b170-se.x
>  1186 user3   25   0  155m  62m  640 R 50.2 12.3 103:25.22 b170-se.x
> 
> The job with nice 19 seems to be using 100% of cpu time while the
> other two nice 0 jobs share a single processor with 50% only. This is
> persistent, not a transient. I did a kill -STOP to the nice 19 job and
> a kill -CONT, and for a while it decreased the cpu usage but later
> returned to the above.
> 
> This is with kernel 2.6.11-5 and top 3.2.5. What's the reason for this
> (apparent??) mis-behavior and how can I correct it? This is important
> because the machine is used for number-crunching and users get really
> upset when they don't get the expected share of cpu time...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


