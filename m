Return-Path: <linux-kernel-owner+w=401wt.eu-S932555AbXAJMEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbXAJMEH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 07:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbXAJMEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 07:04:07 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:48476 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555AbXAJMEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 07:04:05 -0500
Message-ID: <45A4D5FC.7060808@bull.net>
Date: Wed, 10 Jan 2007 13:03:08 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
Cc: Ulrich Drepper <drepper@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Jakub Jelinek <jakub@redhat.com>,
       Darren Hart <dvhltc@us.ibm.com>,
       =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
References: <45A3B330.9000104@bull.net> <45A3BFC8.1030104@bull.net> <45A3C2CE.7070500@redhat.com> <45A4D249.8080904@bull.net>
In-Reply-To: <45A4D249.8080904@bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/01/2007 13:12:11,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/01/2007 13:12:12,
	Serialize complete at 10/01/2007 13:12:12
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Peiffer a écrit :
> Ulrich Drepper a écrit :
>>
>> I have never seen performance numbers for this.  If it is punishing
>> existing code in a measurable way I think it's not anacceptable default
>> behavior.

> May be, supposing it makes sense to respect the priority order only for 
> real-time pthreads, I can register all SCHED_OTHER threads to the same 
> MAX_RT_PRIO priotity ?

Moreover, the performance must be considered, sure, but after all, "man 
pthread_cond_broadcast" says:
<<
        If more than one  thread  is  blocked  on  a  condition  variable,  the
        scheduling  policy  shall  determine  the  order  in  which threads are
        unblocked.
 >>

... this is not true today ...
(of course, "shall" does not mean "mandatory", I know ;-) )

-- 
Pierre
