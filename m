Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbUAMSLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUAMSLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:11:52 -0500
Received: from main.gmane.org ([80.91.224.249]:62433 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264574AbUAMSLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:11:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens@spamfreemail.de>
Subject: Re: 2.6.1mm2: nforce2 / amd74xx IDE driver doesn't load
Date: Tue, 13 Jan 2004 19:11:27 +0100
Organization: University of the Armed Forces, Hamburg, Germany
Message-ID: <bu1ccg$ouh$1@sea.gmane.org>
References: <2867040.OKCKYgd4AF@spamfreemail.de> <200401131534.53423.bzolnier@elka.pw.edu.pl> <bu13gl$rs2$1@sea.gmane.org> <200401131756.03852.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> On Tuesday 13 of January 2004 16:40, Jens Benecke wrote:
>> Bartlomiej Zolnierkiewicz wrote:
>> >> I have found a (perhaps THE) reason why my X is so jerky: the nforce2
>> >> chipset driver (amd74xx) doesn't load, because it "thinks" the BIOS
>> >> IDE ports are disabled - which is definitely not the case
>> >
>> > It doesn't load because IDE ports are already controlled by generic IDE
>> > code.
>> > Just use CONFIG_BLK_DEV_AMD74XX=y.  I will fix this "BIOS" comment.
>>
>> I can't, because I (plan to) use this kernel on many different machines.
>> Not all of those (in fact: only one) uses the amd74xx module.
> 
> So what?  It won't be used on other machines, but it will eat a little
> kernel image space & memory.

Then I'd have to statically compile in *all* IDE modules.
The point is that I'm providing specially configured kernels for a large
group of users, most of which I don't even know (much less their hardware
configurations).
 
>> Is there a kernel parameter I can use to disable the generic IDE code on
>> boot?
> 
> No, but I will later make patch to allow disabling/modularizing it.

That'd be great. :-)
Thanks!


PS: this worked in 2.4 (loading the IDE driver later as module, but booting
from IDE as well), why doesn't it work in 2.6 any more?


-- 
Jens Benecke (jens at spamfreemail.de)
http://www.hitchhikers.de - Europaweite kostenlose Mitfahrzentrale
http://www.spamfreemail.de - 100% saubere Postfächer - garantiert!
http://www.rb-hosting.de - PHP ab 9? - SSH ab 19? - günstiger Traffic

