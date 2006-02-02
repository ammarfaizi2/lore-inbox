Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423368AbWBBIFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423368AbWBBIFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423370AbWBBIFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:05:41 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:18296 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1423368AbWBBIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:05:40 -0500
In-Reply-To: <A20324D8-446C-4760-9ECC-64FA9736E783@kernel.crashing.org>
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <A20324D8-446C-4760-9ECC-64FA9736E783@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6E8F349B-CD5A-473E-A2E1-21CFD949E83E@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rmk+kernel@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 8250 serial console fixes -- issue
Date: Thu, 2 Feb 2006 02:05:40 -0600
To: Kumar Gala <galak@kernel.crashing.org>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 1, 2006, at 11:54 PM, Kumar Gala wrote:

>
> On Feb 1, 2006, at 7:47 PM, Alan Cox wrote:
>
>> On Mer, 2006-02-01 at 19:21 -0600, Kumar Gala wrote:
>>> This patch introduces an issue for me an embedded PowerPC SoC  
>>> using the
>>> 8250 driver.
>>>
>>> The simple description of my issue is this:  I'm using the serial  
>>> port for
>>> both a terminal and console.  I run fdisk on a /dev/hda.  Before  
>>> this
>>> patch I would get the prompt for fdisk immediately.  After this  
>>> patch I
>>> have to hit return before the prompt is displayed.
>>>
>>> I know that's not a lot of info, but just let me know what else  
>>> you need
>>> to help debug this.
>>>
>>> I'm guessing something about the UARTs on the PowerPC maybe bit a  
>>> little
>>> non-standard.
>>
>> I wonder if I've swapped one race for another. Can you revert just  
>> the
>> line which forces THRI on and test with the rest of the change  
>> please.
>
> This doesn't seem to help.

I realized a bit later that the kernel I build with your suggested  
change wasn't the one I was testing.  After loading the proper kernel  
this does make the issue I was seeing go away.

- kumar
