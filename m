Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264684AbUDVVar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264684AbUDVVar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUDVVar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:30:47 -0400
Received: from fmr10.intel.com ([192.55.52.30]:44693 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S264684AbUDVVao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:30:44 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Len Brown <len.brown@intel.com>
To: Jesse Allen <the3dfxdude@hotmail.com>
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
In-Reply-To: <1082654469.16333.351.camel@dhcppc4>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404160110.37573.ross@datscreative.com.au>
	 <1082060255.24425.180.camel@dhcppc4>
	 <1082063090.4814.20.camel@amilo.bradney.info>
	 <1082578957.16334.13.camel@dhcppc4> <4086E76E.3010608@gmx.de>
	 <1082587298.16336.138.camel@dhcppc4>  <20040422163958.GA1567@tesore.local>
	 <1082654469.16333.351.camel@dhcppc4>
Content-Type: text/plain
Organization: 
Message-Id: <1082669345.16332.411.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 17:29:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 13:21, Len Brown wrote:

> > As for your patch, I get a fast timer, and gain about 1 sec per 5 minutes.
> > The only patch that seemed to work without a fast timer so far was the one 
> > removed by Linus in a testing version.  The AN35N has the timer override 
> > bug.
> 
> Hmm, I didn't notice fast time on my FN41, i'll look for it.
> 
> I'm not familiar with the "one removed by Linux in a testing version",
> perhaps you could point me to that?

date seems to gain 9sec/hour on my Shuttle/SN41G2/FN41 when using IOAPIC
timer.

booted with "noapic" for XT-PIC timer, it stays locked
onto my wristwatch after an hour.  If the workaround is disabled,
and XT-PIC timer is used, it matches the "noapic" behaviour -- no drift.

I can't explain it.  I think it is a timer problem independent of the
IRQ routing.

-Len

ps. when i ran in XT-PIC mode there were lots of ERR's registered in
/proc/interrupts -- doesn't look healthy.



