Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVERW0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVERW0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVERWWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:22:22 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:41012
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S262408AbVERWUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:20:47 -0400
Message-ID: <428BBFB3.4090702@ev-en.org>
Date: Wed, 18 May 2005 23:20:35 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Filipe Abrantes <fla@inescporto.pt>, linux-kernel@vger.kernel.org
Subject: Re: Detecting link up
References: <428B1A60.6030505@inescporto.pt> <428B876F.8080802@osdl.org>
In-Reply-To: <428B876F.8080802@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> Filipe Abrantes wrote:
> 
>> Hi all,
>>
>> I need to detect when an interface (wired ethernet) has link up/down.
>> Is there a system signal which is sent when this happens? What is the
>> best way to this programatically?
>>
>> Best Regards
>>
>> Filipe
>>
>>
> 
> The best way is to open a netlink socket and look for the mesaages about
> link up/down there. Read iproute2 http://developer.osdl.org/dev/iproute2
> source for ip command (ipmonitor.c).
> 
> This works for almost all devices unlike ethtool and mii which only
> work on a small subset of devices.

And libnl is a very good library to get just that information without
the need to manually parse netlink messages.

Baruch
