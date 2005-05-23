Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVEWILq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVEWILq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 04:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEWILq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 04:11:46 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:17843 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261848AbVEWILn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 04:11:43 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Date: Mon, 23 May 2005 01:11:28 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: weird X problem - priority inversion?
In-Reply-To: <20050523075508.GC9287@elte.hu>
Message-ID: <Pine.LNX.4.62.0505230110240.7165@qynat.qvtvafvgr.pbz>
References: <1113428938.16635.13.camel@mindpipe> <20050523075508.GC9287@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remember that the low pri screensaver is just generating the image to be 
displayed, it's the high pri X server that's actually doing the work to 
display it.

David Lang

On Mon, 23 May 2005, Ingo Molnar wrote:

> does this still occur with the latest tree? (.47-05 or later)
>
> 	Ingo
>
> * Lee Revell <rlrevell@joe-job.com> wrote:
>
>> I am having a problem with the RT preempt kernels where xscreensaver
>> will cause the X server to consume excessive CPU, starving other
>> processes.  This should not happen as xscreensaver runs at the highest
>> nice value.  It seems that there's some kind of priority inversion
>> happening between the high prio X server and low prio xscreensaver.
>>
>> This seems like an X problem to me, but could the kernel be involved?
>>
>> Lee
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
