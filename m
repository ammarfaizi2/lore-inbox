Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUFRVP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUFRVP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbUFRVNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:13:09 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:64988 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S263664AbUFRVI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:08:57 -0400
Message-ID: <40D359BB.3090106@pacbell.net>
Date: Fri, 18 Jun 2004 14:08:11 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com
Subject: Re: DMA API issues
References: <1087582845.1752.107.camel@mulgrave>	<20040618193544.48b88771.spyro@f2s.com>	<1087584769.2134.119.camel@mulgrave>	<20040618195721.0cf43ec2.spyro@f2s.com> <40D34078.5060909@pacbell.net> 	<20040618204438.35278560.spyro@f2s.com> <1087588627.2134.155.camel@mulgrave>
In-Reply-To: <1087588627.2134.155.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2004-06-18 at 14:44, Ian Molton wrote:
> 
>>>For example, if usbaudio uses usb_buffer_alloc to stream data,
>>>that eliminates dma bouncing.  That's dma_alloc_coherent at
>>>its core ... it should allocate from that 32K region.
>>
>>Agreed.
> 
> 
> There are complications to this: not all platforms can access PCI memory
> directly.  That's why ioremap and memcpy_toio and friends exist.  What
> should happen on these platforms?

I'm not following you.  This isn't using the PCI DMA calls.
These dots don't connect:  different hardware needs different
solutions.  How would those calls make dma_alloc_coherent work?

- Dave

