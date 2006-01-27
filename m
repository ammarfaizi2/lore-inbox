Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWA0FWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWA0FWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 00:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWA0FWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 00:22:30 -0500
Received: from main.gmane.org ([80.91.229.2]:38312 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932407AbWA0FW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 00:22:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [RFT] sky2: pci express error fix
Date: Fri, 27 Jan 2006 14:22:00 +0900
Message-ID: <drcalp$oq9$1@sea.gmane.org>
References: <200601190930.k0J9US4P009504@typhaon.pacific.net.au>	<20060124220533.5fade501@localhost.localdomain>	<drasb9$5jj$1@sea.gmane.org> <20060126095145.7d6fc4e4@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060115)
In-Reply-To: <20060126095145.7d6fc4e4@dxpl.pdx.osdl.net>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Fri, 27 Jan 2006 01:11:20 +0900
> Kalin KOZHUHAROV <kalin@thinrope.net> wrote:
> 
>> Stephen Hemminger wrote:
>>> For all those people suffering with pci express errors
>>> on the sky2 driver.  The problem is the PCI subsystem sometimes
>>> won't let the sky2 driver write to PCI express registers. It depends
>>> on the phase of the moon (actually ACPI) and number of devices.
>>>
>>> Anyway, this should fix it. Please tell me if it solves it for you.
>> Can you describe the bug a bit more? What happens?
>>
>> I had a few times something like this:
>>
>> [   24.145040] sky2 eth0: phy interrupt status 0x1c40 0xbc0c
> 
>> [ 3647.341757] sky2 eth0: phy interrupt status 0x1c40 0xbc4c
>>
> 
> Looks like a noisy crappy cable causing PHY link status changes.

I will check that particular cable on monday, but it *should* be CAT6 not
very cheap cable (Japanese brand: Elecom). In the worst case it is a CAT5e
from probably the same brand. (just because there are no other cables in the
office)

Can these errors be caused by bad hub?
>From what I've seen the network on this machine dies at the same time (not
sure before or after) as the error in dmesg.

>> after which all network was dead. (and it wasn't a module so had to
>> restart). As you can see from the above two logs, sometimes it failed on
>> boot, sometimes after an hour. Sourry, I didn't remember the phase of the
>> moon, but I can check :-)
>>
>> I have two Asus P5GDC-V Deluxe boards, with these chips. One of them is
>> happily working with sk98lin (the binary one), the other is dying miserably,
>> so now I use r8169 card to be able to isolate the problem (separate mail).
Forgot to post it, now it went under the subject:
	libata errors in 2.6.15.1 ICH6 AHCI (SATA drive WD740GD)

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

