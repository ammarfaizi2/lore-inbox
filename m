Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUDWIsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUDWIsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 04:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264764AbUDWIsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 04:48:40 -0400
Received: from pop.gmx.net ([213.165.64.20]:21175 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264763AbUDWIsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 04:48:38 -0400
X-Authenticated: #4512188
Message-ID: <4088D861.7080601@gmx.de>
Date: Fri, 23 Apr 2004 10:48:33 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Jesse Allen <the3dfxdude@hotmail.com>, Craig Bradney <cbradney@zip.com.au>,
       ross@datscreative.com.au, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <200404131117.31306.ross@datscreative.com.au>	 <200404131703.09572.ross@datscreative.com.au>	 <1081893978.2251.653.camel@dhcppc4>	 <200404160110.37573.ross@datscreative.com.au>	 <1082060255.24425.180.camel@dhcppc4>	 <1082063090.4814.20.camel@amilo.bradney.info>	 <1082578957.16334.13.camel@dhcppc4> <4086E76E.3010608@gmx.de>	 <1082587298.16336.138.camel@dhcppc4>  <20040422163958.GA1567@tesore.local>	 <1082654469.16333.351.camel@dhcppc4> <1082669345.16332.411.camel@dhcppc4>
In-Reply-To: <1082669345.16332.411.camel@dhcppc4>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Thu, 2004-04-22 at 13:21, Len Brown wrote:
> 
> 
>>>As for your patch, I get a fast timer, and gain about 1 sec per 5 minutes.
>>>The only patch that seemed to work without a fast timer so far was the one 
>>>removed by Linus in a testing version.  The AN35N has the timer override 
>>>bug.
>>
>>Hmm, I didn't notice fast time on my FN41, i'll look for it.
>>
>>I'm not familiar with the "one removed by Linux in a testing version",
>>perhaps you could point me to that?
> 
> 
> date seems to gain 9sec/hour on my Shuttle/SN41G2/FN41 when using IOAPIC
> timer.

Do you get lock-ups wihtout the timer_ack/C1halt patch? If yes, this may 
be the cause. I remember someone finding out that Ross' patch made the 
timer actually slower which resulted in stable operation. Maciej found 
out, not connecting the timer at all made it stabke as well. So is there 
a possibility to sync both timers?

According to a recent post, builöding kernel with SMP makes it stable, 
as well, but I haven't tested.

> booted with "noapic" for XT-PIC timer, it stays locked
> onto my wristwatch after an hour.  If the workaround is disabled,
> and XT-PIC timer is used, it matches the "noapic" behaviour -- no drift.
> 
> I can't explain it.  I think it is a timer problem independent of the
> IRQ routing.
> 
> -Len
> 
> ps. when i ran in XT-PIC mode there were lots of ERR's registered in
> /proc/interrupts -- doesn't look healthy.
> 
> 
> 
> 

