Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVAYG3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVAYG3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVAYG3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:29:09 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:335 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261837AbVAYG3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:29:05 -0500
Message-ID: <41F5E727.4000208@yahoo.com.au>
Date: Tue, 25 Jan 2005 17:28:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
CC: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>	<20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us>
In-Reply-To: <87k6q2umla.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> 
>>* Ingo Molnar <mingo@elte.hu> wrote:
>>
>>this patch adds the /proc/sys/kernel/rt_cpu_limit tunable: the maximum
>>amount of CPU time all RT tasks combined may use, in percent. Defaults
>>to 80%.
>>
>>just apply the patch to 2.6.11-rc2 and you should be able to run e.g. 
>>"jackd -R" as an unprivileged user.
> 
> 
> This is a far better idea from an API perspective.  We can continue
> writing to the POSIX realtime standard interfaces.  Yet users can
> actually take advantage of them.  I like it.
> 

This still doesn't solve your privlige problem though. If I can't
renice something as a regular user, it makes no sense to allow such
realtime behaviour.

I still think the ulimit patches aren't a bad idea to solve your
privilege problem. At that point, is there still a need for
rt_cpu_limit?

Nick

