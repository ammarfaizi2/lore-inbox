Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265763AbUFRXk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUFRXk4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUFRXhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:37:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8085 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265786AbUFRXdN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:33:13 -0400
Message-ID: <40D37BA5.8070704@pobox.com>
Date: Fri, 18 Jun 2004 19:32:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, david-b@pacbell.net,
       jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
References: <20040618175902.778e616a.spyro@f2s.com>	<40D359B3.6080400@pobox.com>  <20040619002618.5650e16a.spyro@f2s.com> <1087601446.2134.211.camel@mulgrave>
In-Reply-To: <1087601446.2134.211.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2004-06-18 at 18:26, Ian Molton wrote:
> 
>>On Fri, 18 Jun 2004 17:08:03 -0400
>>Jeff Garzik <jgarzik@pobox.com> wrote:
>>
>>>You _might_ convince the kernel DMA gurus that this could be done by 
>>>creating a driver-specific bus, and pointing struct device to that 
>>>internal bus, but that seems like an awful lot of work as opposed to the 
>>>wrappers.
>>
>>Its an awful lot less work than re-writing all those drivers!
> 
> 
> Every other driver bar this one already copes correctly with on chip
> memory using the ioremap methods.  That's why we're all wondering if it
> isn't simpler to fix this driver.


Indeed...  if the SRAM is accessible via ioremapped memory, DMA API 
shouldn't be needed.

	Jeff


