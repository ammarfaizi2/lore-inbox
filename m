Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVAOXKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVAOXKI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVAOXKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:10:08 -0500
Received: from mail.joq.us ([67.65.12.105]:46978 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262355AbVAOXKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:10:02 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	<1105132348.20278.88.camel@krustophenia.net>
	<20050107134941.11cecbfc.akpm@osdl.org>
	<20050107221059.GA17392@infradead.org>
	<20050107142920.K2357@build.pdx.osdl.net>
	<87mzvkxxck.fsf@sulphur.joq.us> <20050111212139.GA22817@elte.hu>
	<87ekgnwaqx.fsf@sulphur.joq.us> <20050115144302.GG10114@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 15 Jan 2005 17:10:57 -0600
In-Reply-To: <20050115144302.GG10114@elte.hu> (Ingo Molnar's message of
 "Sat, 15 Jan 2005 15:43:02 +0100")
Message-ID: <87r7kmuw3i.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> * Jack O'Quin <joq@io.com> wrote:
>
>> --- kernel/sched.c~	Fri Dec 24 15:35:24 2004
>> +++ kernel/sched.c	Wed Jan 12 23:48:49 2005
>> @@ -95,7 +95,7 @@
>>  #define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
>>  #define INTERACTIVE_DELTA	  2
>>  #define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
>> -#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
>> +#define STARVATION_LIMIT	0
>>  #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
>>  #define CREDIT_LIMIT		100

Ingo Molnar <mingo@elte.hu> writes:
> could you try the patch below? The above patch wasnt enough. With the
> patch below we turn off the starvation limits for nice --20 tasks only. 
> This is still a hack only. If we cannot make nice --20 perform like
> RT-prio-1 then there's some problem with SCHED_OTHER scheduling.

I am building again with your new patch and with STARVATION_LIMIT
defined as (MAX_SLEEP_AVG) again.  I'll run that with a modified JACK
to reduce the interference of all those other non-realtime threads.

Will let you know what happens.
-- 
  joq
