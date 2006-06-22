Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWFVP0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWFVP0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWFVP0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:26:39 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:64748 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S932428AbWFVP0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:26:39 -0400
Message-ID: <449AB69C.6090207@draigBrady.com>
Date: Thu, 22 Jun 2006 16:26:20 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Dropping Packets in 2.6.17
References: <20060622150357.37194.qmail@web33302.mail.mud.yahoo.com>
In-Reply-To: <20060622150357.37194.qmail@web33302.mail.mud.yahoo.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:
> 
> --- Pádraig Brady <P@draigBrady.com> wrote:
> 
>>For reference with 2.4.20 on a dual 3.4GHz xeon
>>and 2 x e1000 cards, I was able to capture,
>>classify and do statistical calculations
>>on 625Kpps per interface (1.3 million pps).
> 
> Unfortunately I can do that much with FreeBSD 4.x
> with 1 2.0Ghz opteron, so its not a very
> compelling case to have to spend twice as much on
> hardware to use LINUX. However 2.4 seemed much
> better than 2.6 in this regard. 2.6 wants to drop
> a lot more packets. The goal of using 2.6 is to
> utilize DP better, but it obviously has to
> perform better than a UP Freebsd box.

NC.

> What ITR setting are using for the e1000 driver?

I didn't use ITR, I used NAPI.

>># Lots of kernel memory needed for e1000 
>>vm.min_free_kbytes = 65535 
> 
> 
> I'm curious as to why a vm setting is useful, as
> it doesn't seem that the e1000 driver uses
> virtual memory? Since rings are replenished with
> sk_buffs, and sk_buffs have to be contiguous, how
> does vm come into play?

Contiguous? The [tr]x descriptors contain
pointers to the skbufs.
Anyway I bypassed the large allocation overhead
by using skb recycling.

Pádraig.
