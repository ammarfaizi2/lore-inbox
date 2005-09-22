Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbVIVCq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbVIVCq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 22:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVIVCq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 22:46:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49831 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965220AbVIVCqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 22:46:55 -0400
Message-ID: <43321B19.7000302@pobox.com>
Date: Wed, 21 Sep 2005 22:46:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matheus Izvekov <izvekov@lps.ele.puc-rio.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: libata sata_sil broken on 2.6.13.1
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br><60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br><43290893.7070207@pobox.com><1126790860.19133.75.camel@localhost.localdomain><61929.200.141.106.169.1126815191.squirrel@correio.lps.ele.puc-rio.br>       <1126823405.7034.14.camel@localhost.localdomain>    <61375.200.141.106.169.1126842173.squirrel@correio.lps.ele.puc-rio.br>    <432A6923.2070000@pobox.com> <60542.200.141.101.221.1126908642.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <60542.200.141.101.221.1126908642.squirrel@correio.lps.ele.puc-rio.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matheus Izvekov wrote:
>>Essentially that is what happened.  Albert's patch simply fixed it
>>another way.
>>
>>ATA is a bit annoying in that, we try to "know" when an interrupt is
>>expected.  There is no 100% solution that simply allows us to check for
>>pending interrupts, without side effects.
>>
>>Thus the explosion when unexpected interrupts are received.
>>
> 
> 
> What do you think would be proper fix, this patch from Albert, or maybe

Albert's patch should be the proper fix.


> just trapping the interrupts (plus not have the IRQ shared with other
> devices?). Also, what keeps Albert's patch from making into mainline, it
> just needs more testing or are there any known problems?

Albert's patch needs to be fleshed out a bit more.  No fundamental 
problems, just the stuff I mentioned, plus a final review.

It also needs to be tested on EVERY controller that we support, since 
this is a fundamental change in how ALL sata devices are probed.

	Jeff


