Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264749AbUDWJBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264749AbUDWJBx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 05:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264766AbUDWJBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 05:01:53 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:47042 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id S264749AbUDWJBu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 05:01:50 -0400
Date: Fri, 23 Apr 2004 11:01:24 +0200 (METDST)
From: Arjen Verweij <A.Verweij2@ewi.tudelft.nl>
Reply-To: a.verweij@student.tudelft.nl
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
cc: Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, <ross@datscreative.com.au>,
       <christian.kroener@tu-harburg.de>, <linux-kernel@vger.kernel.org>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
In-Reply-To: <4088D861.7080601@gmx.de>
Message-ID: <Pine.GHP.4.44.0404231100220.21279-100000@elektron.its.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

He even filed a bug report:

http://bugme.osdl.org/show_bug.cgi?id=2552

I don't have access to my box atm, but I will certainly be trying a
vanilla kernel built with SMP to see what's going on.

Regards,

Arjen

On Fri, 23 Apr 2004, Prakash K. Cheemplavam wrote:

> Len Brown wrote:
> > On Thu, 2004-04-22 at 13:21, Len Brown wrote:
> >
> >
> >>>As for your patch, I get a fast timer, and gain about 1 sec per 5 minutes.
> >>>The only patch that seemed to work without a fast timer so far was the one
> >>>removed by Linus in a testing version.  The AN35N has the timer override
> >>>bug.
> >>
> >>Hmm, I didn't notice fast time on my FN41, i'll look for it.
> >>
> >>I'm not familiar with the "one removed by Linux in a testing version",
> >>perhaps you could point me to that?
> >
> >
> > date seems to gain 9sec/hour on my Shuttle/SN41G2/FN41 when using IOAPIC
> > timer.
>
> Do you get lock-ups wihtout the timer_ack/C1halt patch? If yes, this may
> be the cause. I remember someone finding out that Ross' patch made the
> timer actually slower which resulted in stable operation. Maciej found
> out, not connecting the timer at all made it stabke as well. So is there
> a possibility to sync both timers?
>
> According to a recent post, builöding kernel with SMP makes it stable,
> as well, but I haven't tested.
>
> > booted with "noapic" for XT-PIC timer, it stays locked
> > onto my wristwatch after an hour.  If the workaround is disabled,
> > and XT-PIC timer is used, it matches the "noapic" behaviour -- no drift.
> >
> > I can't explain it.  I think it is a timer problem independent of the
> > IRQ routing.
> >
> > -Len
> >
> > ps. when i ran in XT-PIC mode there were lots of ERR's registered in
> > /proc/interrupts -- doesn't look healthy.
> >
> >
> >
> >
>
>

