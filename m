Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVCTBuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVCTBuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 20:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVCTBuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 20:50:25 -0500
Received: from relay03.pair.com ([209.68.5.17]:32531 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S261964AbVCTBuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 20:50:19 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <423CD6E0.2000806@cybsft.com>
Date: Sat, 19 Mar 2005 19:50:24 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-00
References: <20050319191658.GA5921@elte.hu> <1111282389.15947.2.camel@mindpipe>
In-Reply-To: <1111282389.15947.2.camel@mindpipe>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2005-03-19 at 20:16 +0100, Ingo Molnar wrote:
> 
>>the biggest change in this patch is the merge of Paul E. McKenney's
>>preemptable RCU code. The new RCU code is active on PREEMPT_RT. While it
>>is still quite experimental at this stage, it allowed the removal of
>>locking cruft (mainly in the networking code), so it could solve some of
>>the longstanding netfilter/networking deadlocks/crashes reported by a
>>number of people. Be careful nevertheless.
> 
> 
> With PREEMPT_RT my machine deadlocked within 20 minutes of boot.
> "apt-get dist-upgrade" seemed to trigger the crash.  I did not see any
> Oops unfortunately.
> 
> Lee
> 

Lee,

Just curious. Is this with UP or SMP? I currently have my UP box running 
  PREEMPT_RT, with no problems thus far. However, my SMP box dies while 
booting (with an oops). I am working on trying to get setup to capture 
the oops, although it might be tomorrow before I get that done.

-- 
    kr
