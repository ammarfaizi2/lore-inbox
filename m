Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWIWXfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWIWXfh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 19:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWIWXfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 19:35:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39379
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750910AbWIWXfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 19:35:36 -0400
Date: Sat, 23 Sep 2006 16:35:35 -0700 (PDT)
Message-Id: <20060923.163535.41636370.davem@davemloft.net>
To: hadi@cyberus.ca
Cc: jbglaw@lug-owl.de, joro-lkml@zlug.org, kaber@trash.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <1159015118.5301.19.camel@jzny2>
References: <20060923120704.GA32284@zlug.org>
	<20060923121327.GH30245@lug-owl.de>
	<1159015118.5301.19.camel@jzny2>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: jamal <hadi@cyberus.ca>
Date: Sat, 23 Sep 2006 08:38:37 -0400

> You just need to use GRE tunnel instead of what you describe above.
> 
> While i feel bad that Joerg (and Lennert and others before) have put the
> effort to do the work, i too question the need for this driver. I dont
> think even the authors of the original RFC feel this provides anything
> that GRE cant (according to some posting on netdev that one of the
> authors made). My understanding is also that the only other OS that
> implemented this got it wrong - hence you will have to interop with them
> and provide quirks checks.
> 
> I am actually curious if anyone uses it instead of GRE in openbsd?
> You could argue that including this driver would allow Linux to have
> another bulb in the christmas tree; the other (more pragmatic way) to
> look at this is it allows spreading a bad idea and needs to be censored.
> I prefer the later - and hope this doesnt discourage Joerg from
> contributing in the future.

First, the only mentioned real use of EtherIP I've seen anywhere is to
tunnel old LAN based games that used protocols other than IP :-)

Second, the OpenBSD interoperability issues are very real, and there
is even a Xerox implementation that used an 8-bit instead of a 16-bit
header size.

Third, even the introductory material in RFC3378 mentions that people
are strongly encouraged to use other technologies over EtherIP.

Fourth, and finally, if GRE can provide the same functionality then
that plus the first three points makes EtherIP something we really
should not latch onto.

And if it doesn't go in, it's not the end of the world.  Anyone can
maintain and use the external patch, and if usage gets widespread
enough we'll of course be required to reevaluate integration.

So I think we should pass on this for now.
