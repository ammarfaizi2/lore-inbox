Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbVIIQMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbVIIQMg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVIIQMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:12:36 -0400
Received: from mail.tmr.com ([64.65.253.246]:10633 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1030195AbVIIQMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:12:35 -0400
Message-ID: <4321B80E.8090801@tmr.com>
Date: Fri, 09 Sep 2005 12:27:58 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
References: <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com> <20050905063229.GB4294@in.ibm.com> <431F11FF.2000704@tmr.com> <29495f1d0509070942688059a6@mail.gmail.com> <20050907171756.GB28387@in.ibm.com>
In-Reply-To: <20050907171756.GB28387@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:

>On Wed, Sep 07, 2005 at 09:42:24AM -0700, Nish Aravamudan wrote:
>  
>
>>Hrm, got dropped from the Cc... :) Yes, the dynamic-tick generic
>>infrastructure being proposed, with the idle CPU mask and the
>>set_all_cpus_idle() tick_source hook, would allow exactly this in
>>arch-specific code.
>>    
>>
>
>I think Bill is referring to the "resume" interface i.e an
>unset_all_cpus_idle() interface, which is missing (set/unset
>probably are not good prefixes maybe?). I feel we can
>add one.
>
Exactly what I had in mind. If there are hooks for all_idle transitions 
then architectures can hang whatever makes sense there. That hopefully 
would result in readable code for both power reduction (laptop) and for 
the strange things that embedded systems sometimes do.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

