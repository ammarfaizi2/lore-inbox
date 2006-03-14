Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWCNTzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWCNTzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 14:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWCNTzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 14:55:05 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:51370 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750882AbWCNTzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 14:55:04 -0500
Message-ID: <44171F92.8030702@bootc.net>
Date: Tue, 14 Mar 2006 19:54:58 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mail/News 1.5 (X11/20060114)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: New libata PATA patch for 2.6.16-rc1
References: <1142262431.25773.25.camel@localhost.localdomain> <200603131713.31411.s0348365@sms.ed.ac.uk> <1142299457.25773.43.camel@localhost.localdomain> <200603141048.39785.s0348365@sms.ed.ac.uk>
In-Reply-To: <200603141048.39785.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Tuesday 14 March 2006 01:24, Alan Cox wrote:
>> On Llu, 2006-03-13 at 17:13 +0000, Alistair John Strachan wrote:
>>> However, I just tried the same driver on my desktop PC (4xSATA HDs,
>>> 1xPATA) and I get the following periodically (when the PATA device is NOT
>>> being used):
>> Can you try the vanilla rc6 kernel to check, and if it does it then let
>> Jeff Garzik known ASAP - especially if rc4 was ok.
>>
>>> ata1: irq trap
> 
> No such error without your patch on this machine. I've got a RAID5 spanning 
> four SATA drives on a dual core Athlon 64, and it'll happily do 185MB/s 
> to /dev/null with the command:
> 
> for FILE in *; do dd if="$FILE" of=/dev/null bs=1M; done
> 
> 300,000 interrupts later, still no messages. Anything I can do to isolate this 
> further?
> 

I'd like to second this. On -rc5-ide{1,2} I didn't have any trouble, but now on 
-rc6-ide1 I keep getting the messages on all 4 of my SATA drives (2 on sata_via, 
2 on sata_sil). I haven't tried with vanilla -rc6 but let me know if that can help.

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
