Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUEXG6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUEXG6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUEXG6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:58:37 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:45481 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261181AbUEXG6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:58:36 -0400
Message-ID: <40B19D15.1090105@yahoo.com.au>
Date: Mon, 24 May 2004 16:58:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Con Kolivas <kernel@kolivas.org>, Billy Biggs <vektor@dumbterm.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tvtime and the Linux 2.6 scheduler
References: <20040523154859.GC22399@dumbterm.net> <200405240254.20171.kernel@kolivas.org> <20040524084334.GB24967@elte.hu>
In-Reply-To: <20040524084334.GB24967@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>>     33 ms : time per NTSC frame
>>
>>snip
>>
>>The followup email from someone describing good performance may help
>>us understand what's going on. Your example of poor performance is one
>>when the cpu performance is marginal to get exactly 30 fps processed
>>and on the screen. The cpu overhead in 2.6 is slightly higher than 2.4
>>so a borderline case may be just pushed over. 
> 
> 
> most of the cpu overhead comes from HZ=1000. Especial with SCHED_FIFO
> there should be minimal (if any) impact from the scheduler changes -
> SCHED_FIFO tasks get all CPU time, no ifs and whens.
> 
> could people who experience tvtime performance problems apply the patch
> below to change HZ back to 100? Does it have any impact?
> 

Just one other thing - realtime scheduling was basically broken up
until around 2.6.5. Before starting any tests, please ensure first
that you are using at least the 2.6.5 kernel. Thanks.
