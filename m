Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289376AbSAODTV>; Mon, 14 Jan 2002 22:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289385AbSAODTM>; Mon, 14 Jan 2002 22:19:12 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:48302 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S289376AbSAODTG>; Mon, 14 Jan 2002 22:19:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] O(1) scheduler-H6/H7 and nice +19
Date: Mon, 14 Jan 2002 22:19:04 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>
In-Reply-To: <Pine.LNX.4.40.0201141829230.937-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0201141829230.937-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020115031905.01B0624AC1@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 14, 2002 09:33 pm, Davide Libenzi wrote:
> try to replace :
>
> PRIO_TO_TIMESLICE() and RT_PRIO_TO_TIMESLICE() with :
>
> #define NICE_TO_TIMESLICE(n)    (MIN_TIMESLICE + ((MAX_TIMESLICE - \
> 	MIN_TIMESLICE) * ((n) + 20)) / 39)
>
>
> NICE_TO_TIMESLICE(p->__nice)

Not sure about this change.  gkrellm shows the compile getting about 40%
cpu.  Best result here seems to be with a larger range of timeslices.  ie
1-15 ((10*HZ)/1000...) instead lets the compile get 80% of the cpu.  wonder
if this might be the way to go?

Ed  
