Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUCTTMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263511AbUCTTMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:12:34 -0500
Received: from pop.gmx.de ([213.165.64.20]:44160 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263510AbUCTTMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:12:32 -0500
X-Authenticated: #4512188
Message-ID: <405C979A.8070200@gmx.de>
Date: Sat, 20 Mar 2004 20:12:26 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc2, hotplug and ohci-hcd issue
References: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org> <405C1B14.6000206@gmx.de> <20040320132334.GB13028@gemtek.lt>
In-Reply-To: <20040320132334.GB13028@gemtek.lt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zilvinas Valinskas wrote:
> Exactly the same here on Debian/Unstable 2.6.5-rc2.
> 
> Though I can't say it locks up on. Remove modules manually
> rmmod ehci_hcd
> rmmod ohci_hcd
> 
> Usually it takes some time and eventually rmmod returns successfully
> removing modules !
[snip]

You could also try to run /etc/hotplug/usb.rc stop and 
/etc/hotplug/usb.rc start in case you have those scripts.

> On Sat, Mar 20, 2004 at 11:21:08AM +0100, Prakash K. Cheemplavam wrote:
>>
>>it already started with 2.6.5-rc1: On shutdown/reboot when hotplug 
>>service stops, it hangs. I found out that hotplug has trouble in 
>>removing ohci-hcd module, ie, it doesn't seem to work. killall -9 rmmod 
>>doesn't remove that process, neither. (Module unloading is in the kernel).

I maybe found something: I compiled "force module unloading" into 
kernel, and now it doesn't seem to hang, though I don't understand why 
it should make a difference, as nothing is forced. I have to test a bit 
more.

Prakash
