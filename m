Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265945AbUFTVAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265945AbUFTVAG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUFTVAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:00:06 -0400
Received: from crl-mail.crl.dec.com ([192.58.206.9]:62127 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S265945AbUFTVAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:00:01 -0400
Message-ID: <40D5FAC7.7060601@hp.com>
Date: Sun, 20 Jun 2004 16:59:51 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040229)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, david-b@pacbell.net,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, joshua@joshuawise.com
Subject: Re: DMA API issues
References: <1087582845.1752.107.camel@mulgrave>	<20040618193544.48b88771.spyro@f2s.com>	<1087584769.2134.119.camel@mulgrave>	<20040618195721.0cf43ec2.spyro@f2s.com> <40D34078.5060909@pacbell.net>	<20040618204438.35278560.spyro@f2s.com>	<1087588627.2134.155.camel@mulgrave>	<20040619002522.0c0d8e51.spyro@f2s.com>	<1087601363.2078.208.camel@mulgrave>	<20040619005106.15b8c393.spyro@f2s.com>	<1087603453.2135.224.camel@mulgrave> 	<20040619011416.64d16c4e.spyro@f2s.com> <1087616990.2078.240.camel@mulgrave>
In-Reply-To: <1087616990.2078.240.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-3.508, required 5, BAYES_00 -4.90,
	NO_STRINGS 1.39)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>On Fri, 2004-06-18 at 19:14, Ian Molton wrote:
>  
>
>>On 18 Jun 2004 19:04:11 -0500
>>James Bottomley <James.Bottomley@SteelEye.com> wrote:
>>
>>    
>>
>>>Because the piece of memory you wish to access is bus remote. 
>>>      
>>>
>>No, its *not*
>>
>>my CPU can write there directly.
>>
>>no strings attached.
>>
>>the DMA API just only understands how to map from RAM, not anything
>>else.
>>    
>>
>
>I think you'll actually find that it is.  OHCI is a device (representing
>a USB hub), it's attached to the system by some interface that
>constitutes a bus (the bus interface transforming the CPU access cycles
>to device access cycles, translating interrupts etc.).
>
>  
>
Bus remote is a red herring in this case.  The only difference between 
this case and the ones supported by the coherent_dma_mask is that the 
constraint on placement of the allocated memory cannot be encoded as a 
bitmask.

Jamey

