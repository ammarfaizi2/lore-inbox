Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUIWPEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUIWPEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUIWPEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:04:50 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:664 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S268088AbUIWPEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:04:47 -0400
Message-ID: <4152E606.3070609@ppp0.net>
Date: Thu, 23 Sep 2004 17:04:38 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is there a user space pci rescan method?
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <415211A8.8040907@ppp0.net> <20040923002649.GA28259@kroah.com>
In-Reply-To: <20040923002649.GA28259@kroah.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Sep 23, 2004 at 01:58:32AM +0200, Jan Dittmer wrote:
> 
>>Dave Aubin wrote:
>>
>>>Hi,
>>>
>>>  I know very little about hotplug, but does make sense.
>>>How do you motivate a hotplug insertion event?  Or should
>>>I just go read the /docs on hotplugging?  Any help is
>>>Appreciated:)
>>
>>There is a "fake" hotplug driver which works for normal pci. But last
>>time I looked at it, it did only support hot disabling, not hot enabling
>>- but this surely can be fixed.
> 
> 
> Yes, hot "enabling" has been left for someone to add to the driver, if
> you read the comments in it :)
> 

I read them and started playing around with this driver. So echoing 0 in
 /sys/bus/pci/slots/*/power disables the pci device. The problem I see
is, that the tree with the device is disappearing. So how am I supposed
to re-enable the device. I've no real hotplug hardware to play with, so
I'm bound to reading the source code in drivers/pci/hotplug and testing
with fakephp. I found your utility pcihpview (v0.5) which searches for
/sys/bus/pci/hotplug_slots. But grepping the kernel tree doesn't show
any mentioning of it - so I suppose it is outdated.
Is there anywhere a current article (or Documentation/pci_hotplug.txt)
about the state of PCI hotplug and how this is supposed to work?

Thanks,

Jan

ps: Meanwhile I found dummyphp on the pcihpd mailinglist. This doesn't
remove the device from /sys/bus/pci/slots/*/power . Still I'd like
to know the offical way.
