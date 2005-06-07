Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVFGQav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVFGQav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVFGQav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:30:51 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:47627 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261934AbVFGQam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:30:42 -0400
Message-ID: <42A5CBA9.3030704@stud.feec.vutbr.cz>
Date: Tue, 07 Jun 2005 18:30:33 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
References: <20050607110409.GA14613@elte.hu> <Pine.OSF.4.05.10506071638130.28240-100000@da410.phys.au.dk> <20050607160400.GA9904@elte.hu>
In-Reply-To: <20050607160400.GA9904@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0001]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> 
>>Hey,
>> This is an old problem of cpu_freq.c not compiling. I (re)send a fix 
>>for it. This time as a real patch...
> 
> 
> thanks - i've applied it and have released the -47-27 patch with this 
> fix included.

Yes, that's an obviously safe fix.
I asked on the cpufreq mailing list about this lock. Here's the answer I 
got from Dominik Brodowski:

Dominik Brodowski wrote:
> On Wed, Jun 01, 2005 at 06:57:12PM +0200, Michal Schmidt wrote:
> 
>> Hello,
>> I think that it's not necessary to take the policy->lock in cpufreq_add_dev.
>> Am I missing something? What is the lock supposed to protect from?
> 
> 
> Well, indeed it is not necessary to take the policy->lock, although it
> doesn't do any harm AFAICS. I added it to make sure that _all_ accesses to
> the data is protected by the lock, how serialized they may ever be..
> 
> Thanks,
> 	Dominik


Michal
