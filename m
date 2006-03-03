Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWCCXqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWCCXqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWCCXqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:46:46 -0500
Received: from mail.dvmed.net ([216.237.124.58]:14233 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751726AbWCCXqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:46:46 -0500
Message-ID: <4408D55F.4090105@garzik.org>
Date: Fri, 03 Mar 2006 18:46:39 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
CC: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: AMD64 X2 lost ticks on PM timer
References: <200602280022.40769.darkray@ic3man.com> <200603011647.34516.ak@suse.de> <20060301180714.GD20092@ti64.telemetry-investments.com> <200603011929.59307.ak@suse.de> <1141240611.5860.176.camel@mindpipe> <20060303191822.GE32407@ti64.telemetry-investments.com> <1141421204.3042.139.camel@mindpipe> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com>
In-Reply-To: <20060303234330.GA14401@ti64.telemetry-investments.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Rugolsky Jr. wrote:
> On Fri, Mar 03, 2006 at 05:09:57PM -0500, Jeff Garzik wrote:
> 
>>Or sata_nv/libata is to blame.
> 
>  
> In case you are coming late to the thread:

I'm not.  Thus my comments refuting Lee's silly speculation.


> Andi suggested:
> 
>    Yes, I bet something forgets to turn on interrupts again and it's
>    picked up by (and blamed on) the next guy who does an unconditional
>    sti, which happens to be __do_sofitrq or idle.
> 
> That sounds right to me.

Unlikely.  More likely is a disabled interrupt period is longer than a 
tick period, or similar.

	Jeff


