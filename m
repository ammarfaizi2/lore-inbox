Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVBCDLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVBCDLf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 22:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVBCDLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 22:11:30 -0500
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:35809 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S262749AbVBCDKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 22:10:54 -0500
Message-ID: <42019633.80803@bigpond.net.au>
Date: Thu, 03 Feb 2005 14:10:43 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
CC: Paul Davis <paul@linuxaudiosystems.com>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200502022303.j12N3nZa002055@localhost.localdomain> <42016661.80908@bigpond.net.au> <87d5viigyo.fsf@sulphur.joq.us>
In-Reply-To: <87d5viigyo.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> Peter Williams <pwil3058@bigpond.net.au> writes:
> 
> 
>>>>If you have the source code for the programs then they could be
>>>>modified to drop the root euid after they've changed policy.  Or
>>>>even do the
> 
> 
>>Paul Davis wrote:
>>
>>>This is insufficient, since they need to be able to drop RT
>>>scheduling and then reacquire it again later.
> 
> 
>>I believe that there are mechanisms that allow this.  The setuid man
>>page states that a process with non root real uid but setuid as root
>>can use the seteuid call to use the _POSIX_SAVED_IDS mechanism to
>>drop and regain root privileges as required.
> 
> 
> Which every system cracker knows.  Any attack on such a program is
> going to re-acquire root privileges and take over the system.
> 
> Temporarily dropping privileges gains no security whatsoever.  It is
> nothing more than a coding convenience.

Yes, to help avoid accidentally misusing the privileges.

> The program remains *inside*
> the system security perimeter.

Which is why you have to be careful in writing setuid programs.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
