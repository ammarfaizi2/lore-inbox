Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUJNWmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUJNWmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUJNWda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:33:30 -0400
Received: from opersys.com ([64.40.108.71]:2062 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S268024AbUJNWcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:32:55 -0400
Message-ID: <416F0071.3040304@opersys.com>
Date: Thu, 14 Oct 2004 18:40:49 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Zanussi <trz@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
In-Reply-To: <20041014002433.GA19399@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U0

I notice:
+	local_irq_save(flags);
+	____trace(&__get_cpu_var(trace), eip, parent_eip);
+	local_irq_restore(flags);

Why not use the lockless logging available in relayfs, you'll avoid the
interrupt disabling altogether since, umm ... it's lockless.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

