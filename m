Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWCaWLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWCaWLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 17:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWCaWLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 17:11:40 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:6439 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750881AbWCaWLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 17:11:39 -0500
In-Reply-To: <200603311315.14408.david-b@pacbell.net>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org> <200603311236.02665.david-b@pacbell.net> <A164CF6D-0330-46A7-ABF2-87127753E048@kernel.crashing.org> <200603311315.14408.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <61D4885F-D742-4583-939F-FA93A4AAC8D4@kernel.crashing.org>
Cc: spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] Re: question on spi_bitbang
Date: Fri, 31 Mar 2006 16:11:51 -0600
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 31, 2006, at 3:15 PM, David Brownell wrote:

> On Friday 31 March 2006 12:52 pm, Kumar Gala wrote:
>
>> What I'm looking at is the following:
>>
>> * use spi_bitbang_setup() as is
>> * have my chipselect do:
>> 	if (BITBANG_CS_INACTIVE)
>> 		deassert GPIO pin for CS
>> 	else
>> 		set HW mode register (polarity, phase, bit length)
>> 		assert GPIO pin for CS
>> * setup_transfer()
>> 	* set HW mode register (bit length)
>> 	* call bitbang_setup_transfer()
>
> And export bitbang_setup_transfer()?  I guess that makes sense,
> but you should probably rename it then to match the convention for
> the other exported symbols.
>
> Once that's all working, please submit the relevant patch.

Will do.

So I give a new question.  Any issue with adding a rx & tx completion  
to spi_bitbang?  In my HW I get an interrupt when the transmitter is  
done transmitting and one when the receiver is done receiving.  I  
need some way to synchronize and wait for both events to occur before  
continuing on in txrx_word().

- kumar
