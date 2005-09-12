Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVILQkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVILQkN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVILQkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:40:13 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:21416 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932080AbVILQkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:40:11 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4325AFB9.1090304@s5r6.in-berlin.de>
Date: Mon, 12 Sep 2005 18:41:29 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
CC: Matthias Schniedermeyer <ms@citd.de>,
       =?ISO-8859-1?Q?Rog=E9rio_Brit?= =?ISO-8859-1?Q?o?= 
	<rbrito@ime.usp.br>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: eth1394 and sbp2 maintainers
References: <43232875.4040702@s5r6.in-berlin.de> <20050911215504.17bc09a6.rdunlap@xenotime.net> <20050912074758.GB3863@ime.usp.br> <43255ABF.8080500@citd.de>
In-Reply-To: <43255ABF.8080500@citd.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: (0.305) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> Rogério Brito wrote:
>>Let me add my voice to the choir here. I agree with Randy when he says
>>that Stefan does a superb job supporting firewire with Linux.
> 
> Then let me be the voice telling about the flip-side.

...or me, for that matter. :-) Firstly, maintenance is a different job 
than answering questions on linux1394-user or posting a few patches.

> I've used Firewire with SBP2-driver for nearly 4 years and most of the
> time there was one problem or another (beginning from not-SMP-safe to
> "plainly not working" for nearly a year, where i had to downpatch
> Firewire (The nodemanager "desaster") for a very long time)

Sbp2 has been working very well under many Linux 2.4 releases. But there 
were some severe regressions under Linux 2.6.

> When the last problem crept up (sbp2-module couldn't be unloaded if only
> a none-HDD-device was connected) i was so feed up with the continuous
> hassle that i completly replaced my firewire hardware with USB2 Hardware.

This very old problem of Linux 2.6 was recently fixed. But the fix is 
not yet available in any released kernel.

> With USB pluging/unplugging works flawlessly (couldn't say that for 4
> years Firewire). Operating several devices concurrently works flawlessly
> (I was lucky when my 2 devices worked concurrently with Firewire. Most
> of the time only 1 device couldn't be connected without risking
> desaster), in constrast i've had 10 HDDs running concurrently connected
> via USB2 without a problem!

The hotunplug bugs made usage of multiple devices difficult or even 
impossible, and they prevented implementation of some enhancements for 
usage of multiple devices on the same bus. Fortunately these bugs are 
out of the way now.

But besides that, there are still big issues with SCSI command aborts 
especially with soft RAID over sbp2 and with some firmwares, notably 
those with firmware-"R"AID-0. There is no prognosis yet if and when 
these more elusive problems will be sorted out.

> I know that i may have skipped the time where USB hasn't been mature to
> the time where USB was mature, but it got there. So forgive me when i'm
> too negative about firewire and too positive about USB.

On the other hand, there have also been positive reports about usage of 
multiple SBP-2 devices. (I have several too, though mostly quality 
brands...) But you are absolutely right that sbp2 has not been reliable 
for a long time, and still isn't quite there.

> To say it short:
> - Firewire and especially SBP2 haven't been very mature in my 4 YEARS(!)
> using it.
> - As far as i see the userbase just isn't big enough to make it mature.

Yes, there is a smaller user base than for usb-storage. Combine this 
with the complexities of IEEE 1394 and SCSI and of their respective 
Linux implementations, plus near absence of any commercial interest in 
SBP-2 support for Linux. All this contributes to lack of manpower in 
development and lack of maintenance routine, IMO.

> Taking aside some niche usages, i guess firewire WILL DIE because of USB
> sooner then later. For me firewire died 6 month ago. Rest in peace.

FireWire won't die because of USB. There are fields of applications 
which FireWire and USB do not share. Sure, FireWire for _storage_ 
applications will definitively lose more of its already weak market 
share to USB (cheap and slow) and to external SATA (cheap and fast). But 
FireWire won't vanish from storage applications completely, thanks to a 
few unique features like multiple initiator capability, the ability to 
power even 5.25" drives by bus power, or choice of special-purpose cable 
or fiber media.
-- 
Stefan Richter
-=====-=-=-= =--= -==--
http://arcgraph.de/sr/
