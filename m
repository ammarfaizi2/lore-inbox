Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVFXM5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVFXM5o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 08:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVFXM5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 08:57:43 -0400
Received: from crl-mail-dmz.crl.hpl.hp.com ([192.58.210.9]:63618 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S262218AbVFXM53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 08:57:29 -0400
Message-ID: <42BC030C.50207@hp.com>
Date: Fri, 24 Jun 2005 08:56:44 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: dpervushin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core -- revisited
References: <1119529135.4739.6.camel@diimka.dev.rtsoft.ru> <42BADA42.9090908@hp.com> <20050623174349.A12573@flint.arm.linux.org.uk>
In-Reply-To: <20050623174349.A12573@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Thu, Jun 23, 2005 at 11:50:26AM -0400, Jamey Hicks wrote:
>  
>
>>dmitry pervushin wrote:
>>    
>>
>>>we finally decided to rework the SPI core and now it its ready for your comments.. 
>>>Here we have several boards equipped with SPI bus, and use this spi core with these boards; 
>>>Drivers for them are available by request (...and if community approve this patch)
>>>      
>>>
>>I'm glad to see that work is progressing on SPI core.  I've worked on 
>>drivers on both ARM linux and Blackfin uclinux that use SPI and would 
>>prefer that they not be platform specific.
>>    
>>
>
>I worry about SPI at the moment because I can't see how it's being used
>from just this code.
>
>The worry I have is that it appears to contain an algorithm layer.  Would
>this be better as a library for drivers to use, or something like that?
>
>  
>
That's a good point.  I think the only algorithm that really gets shared 
is the bitbanging one, which could be a library, and otherwise it is 
controller specific and might as well be in the adapter.

Jamey


