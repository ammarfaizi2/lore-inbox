Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSI2SpY>; Sun, 29 Sep 2002 14:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSI2SpX>; Sun, 29 Sep 2002 14:45:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19977 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261723AbSI2SpV>;
	Sun, 29 Sep 2002 14:45:21 -0400
Message-ID: <3D974B62.2040805@pobox.com>
Date: Sun, 29 Sep 2002 14:50:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>, akpm@zip.com.au
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain> <3D9748BA.5010704@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 3) Maybe this is an improvement worth considering, maybe not:  I think 
> it would be useful to have "process context timers."  What I mean by 
> this is, make it easier to implement code that can be boiled down to:
>     run in process context
>     sleep for a little while
> Sure I can do this by implementing a timer that does nothing more than 
> call schedule_task(), but that seems a little redundant if done in 
> multiple places :)


To sum, I guess I want something to "run schedule_task() [at least] NN 
usecs from now."  schedule_task_future() ?

