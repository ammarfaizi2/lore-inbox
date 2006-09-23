Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWIWMiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWIWMiu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWIWMiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:38:50 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:42168 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S1751082AbWIWMis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:38:48 -0400
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Joerg Roedel <joro-lkml@zlug.org>, Patrick McHardy <kaber@trash.net>,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060923121327.GH30245@lug-owl.de>
References: <20060923120704.GA32284@zlug.org>
	 <20060923121327.GH30245@lug-owl.de>
Content-Type: text/plain
Organization: ?
Date: Sat, 23 Sep 2006 08:38:37 -0400
Message-Id: <1159015118.5301.19.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-23-09 at 14:13 +0200, Jan-Benedict Glaw wrote:
> On Sat, 2006-09-23 14:07:04 +0200, Joerg Roedel <joro-lkml@zlug.org> wrote:
> > This patchset is the resubmit of the Ethernet over IPv4 tunnel driver
> > for Linux.  I want to thank all reviewers for their annotations and
> > helpfull input.  This version contains some major changes to the driver.
> > It uses an own device type now (ARPHRD_ETHERIP). This fixes the problem
> > that EtherIP devices could not be safely differenced from Ethernet
> > devices. This change also required some other changes. First a second
> > patch to the bridge code is included to allow the use of EtherIP devices
> > in a bridge.  The third patch includes the necessary changes to iproute2
> > (support of the new ARPHRD and general tunnel configuration support for
> >  EtherIP).
> 
> I haven't seen the first submission, but is this driver really needed?
> Can't this be done with creating two tap interfaces on both endpoints
> and bridge them with a local ethernet device using userland software?

You just need to use GRE tunnel instead of what you describe above.

While i feel bad that Joerg (and Lennert and others before) have put the
effort to do the work, i too question the need for this driver. I dont
think even the authors of the original RFC feel this provides anything
that GRE cant (according to some posting on netdev that one of the
authors made). My understanding is also that the only other OS that
implemented this got it wrong - hence you will have to interop with them
and provide quirks checks.

I am actually curious if anyone uses it instead of GRE in openbsd?
You could argue that including this driver would allow Linux to have
another bulb in the christmas tree; the other (more pragmatic way) to
look at this is it allows spreading a bad idea and needs to be censored.
I prefer the later - and hope this doesnt discourage Joerg from
contributing in the future.

cheers,
jamal

