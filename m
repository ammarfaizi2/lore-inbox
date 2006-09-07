Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWIGVEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWIGVEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 17:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWIGVEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 17:04:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:6051 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932198AbWIGVEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 17:04:05 -0400
Message-ID: <4500893D.6090907@pobox.com>
Date: Thu, 07 Sep 2006 17:03:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.A. Magallon" <jamagallon@ono.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: ignore CFA signature
 while sanity-checking an ATAPI device
References: <20060901015818.42767813.akpm@osdl.org>	<20060904013443.797ba40b@werewolf.auna.net>	<20060903181226.58f9ea80.akpm@osdl.org>	<44FB929B.7080405@gmail.com>	<20060905002600.51c5e73b@werewolf.auna.net>	<44FFE7AF.8010808@gmail.com>	<20060907131327.494fd1c2@werewolf.auna.net>	<20060907113224.GA21853@htj.dyndns.org> <20060907132707.38e63155.akpm@osdl.org>
In-Reply-To: <20060907132707.38e63155.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 7 Sep 2006 20:32:24 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> 0x848a in ID word 0 indicates CFA device iff the ID data is obtained
>> from IDENTIFY DEVICE.  For ATAPI devices, 0x848a in ID work 0
>> indicates valid ATAPI device.  Fix sanity check in ata_dev_read_id()
>> such that ATAPI devices reporting 0x848a in ID word 0 is not handled
>> as error.
>>
>> The problem is identified by J.A. Magallon with HL-DT-ST DVDRAM
>> GSA-4120B.
>>
>> Signed-off-by: Tejun Helo <htejun@gmail.com>
>> Cc: J.A. Magallon <jamagallon@ono.com>
>> ---
>> Jeff, this is a regression and thus should go into .19.
> 
> You mean 2.6.18, yes?

Actually, it looks like it should indeed be 2.6.19 (libata #upstream), 
not 2.6.18 (libata #upstream-fixes).  Alan's "add compactflash support" 
patch isn't in 2.6.18-rc.

So, this should -not- be sent for 2.6.18.

	Jeff



