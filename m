Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268156AbUIWQpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268156AbUIWQpB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIWQoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:44:46 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:17635 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S268159AbUIWQmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:42:15 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: Is there a user space pci rescan method?
Date: Thu, 23 Sep 2004 18:49:11 +0200
User-Agent: KMail/1.7
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <20040923002649.GA28259@kroah.com> <4152E606.3070609@ppp0.net>
In-Reply-To: <4152E606.3070609@ppp0.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231849.11597@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> Greg KH wrote:
> > On Thu, Sep 23, 2004 at 01:58:32AM +0200, Jan Dittmer wrote:
> >>Dave Aubin wrote:
> >>>Hi,
> >>>
> >>>  I know very little about hotplug, but does make sense.
> >>>How do you motivate a hotplug insertion event?  Or should
> >>>I just go read the /docs on hotplugging?  Any help is
> >>>Appreciated:)
> >>
> >>There is a "fake" hotplug driver which works for normal pci. But last
> >>time I looked at it, it did only support hot disabling, not hot enabling
> >>- but this surely can be fixed.
> >
> > Yes, hot "enabling" has been left for someone to add to the driver, if
> > you read the comments in it :)

Hot enabling works for month in dummyphp...

> I read them and started playing around with this driver. So echoing 0 in
>  /sys/bus/pci/slots/*/power disables the pci device. The problem I see
> is, that the tree with the device is disappearing. So how am I supposed
> to re-enable the device. I've no real hotplug hardware to play with, so
> I'm bound to reading the source code in drivers/pci/hotplug and testing
> with fakephp. I found your utility pcihpview (v0.5) which searches for
> /sys/bus/pci/hotplug_slots. But grepping the kernel tree doesn't show
> any mentioning of it - so I suppose it is outdated.
> Is there anywhere a current article (or Documentation/pci_hotplug.txt)
> about the state of PCI hotplug and how this is supposed to work?

Just search the archive of pcihpd-discuss@lists.sourceforge.net for dummyphp, 
this is the version that works. I'll rediff it soon and hope Greg will accept 
it this time.

Message-Id to search for: <200403120947.13046@bilbo.math.uni-mannheim.de>

Eike
