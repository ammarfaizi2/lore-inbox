Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVCAB3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVCAB3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCAB3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:29:42 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:2339 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261190AbVCAB3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:29:38 -0500
Date: Mon, 28 Feb 2005 19:29:34 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: swapper: page allocation failure. order:1, mode:0x20
In-reply-to: <1109640134.4229.15.camel@desktop.cunningham.myip.net.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4223C57E.1070407@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3CRTy-82M-27@gated-at.bofh.it> <4223C121.6090904@shaw.ca>
 <1109640134.4229.15.camel@desktop.cunningham.myip.net.au>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Tue, 2005-03-01 at 12:10, Robert Hancock wrote:
> 
>>Bernd Schubert wrote:
>>Essentially the tg3 Ethernet driver is trying to allocate memory to 
>>store a received packet, and is unable to do so. Since this is done 
>>inside interrupt context, this allocation has to be serviced from 
>>physical memory. Order 1 means it only wanted one page of memory, and 
> 
> 
> Minor point, I know, but it's 2 pages of memory. If it couldn't get an
> order zero page, that would be even greater hernia material!

Indeed.. off-by-one error :-)
