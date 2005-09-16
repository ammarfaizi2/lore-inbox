Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbVIPGlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbVIPGlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 02:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbVIPGlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 02:41:49 -0400
Received: from mail.dvmed.net ([216.237.124.58]:48604 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161055AbVIPGlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 02:41:49 -0400
Message-ID: <432A6923.2070000@pobox.com>
Date: Fri, 16 Sep 2005 02:41:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: izvekov@lps.ele.puc-rio.br
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: libata sata_sil broken on 2.6.13.1
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br><60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br><43290893.7070207@pobox.com><1126790860.19133.75.camel@localhost.localdomain><61929.200.141.106.169.1126815191.squirrel@correio.lps.ele.puc-rio.br>    <1126823405.7034.14.camel@localhost.localdomain> <61375.200.141.106.169.1126842173.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <61375.200.141.106.169.1126842173.squirrel@correio.lps.ele.puc-rio.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

izvekov@lps.ele.puc-rio.br wrote:
>From what i understand up to now, my problem wasnt that the controller
> triggered an interrupt with NIEN set, but that the handler was returning
> it as not handled.

Essentially that is what happened.  Albert's patch simply fixed it 
another way.

ATA is a bit annoying in that, we try to "know" when an interrupt is 
expected.  There is no 100% solution that simply allows us to check for 
pending interrupts, without side effects.

Thus the explosion when unexpected interrupts are received.

	Jeff


