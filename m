Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269618AbUIRToL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269618AbUIRToL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 15:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269620AbUIRToL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 15:44:11 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:29650 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S269618AbUIRToH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 15:44:07 -0400
Message-ID: <414C9003.9070707@softhome.net>
Date: Sat, 18 Sep 2004 21:44:03 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.8 (Macintosh/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That will be soon going away with my multi-threaded device discovery
> work.  And I run pci hotplug boxes (and so do all of the PCMCIA/CardBus
> users), so don't discard PCI from being a async bus type :)
> 
> Async is now the norm, and drivers like the microcode module are the
> exception.

   I wanted you to say that.

   That's wrong attitude. I'm working on workstation where 95% of 
hardware plugged 100% of time. That's not exception. Not eerything is 
hot-pluggable USB/FireWire/whatever.

   Event-based hot-plug scripts are great thing. As an implementation. 
But user cares about one thing: 'modprobe usb-storage; mount /whatever' 
working reliably.

   /etc/dev.d probably great thing - but I'm not going to implement FSM 
into every shell script which does modprobe for sake being Ok with 
dynamic /dev/.

   You need to change your attitude for first. For second - come up with 
a way for user space to block until device is here, and if it is not 
here/error detected - fail.

   As it was said before - /all/ we need, is to be able to tell 
discovery phase from idle state of driver. "/All/" is quite much here - 
but it must be a goal.

   I'm absolutely sure, that for PCI devices it is implementable quite 
easy - probing is already done outside of modules. And we know precisely 
are we Ok, or are we not. And we know when we are done. If it is not so 
for USB yet - then it is bug which must be fixed.
