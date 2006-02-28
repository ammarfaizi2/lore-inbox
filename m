Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWB1WTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWB1WTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWB1WTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:19:12 -0500
Received: from mail.atl.external.lmco.com ([192.35.37.50]:13260 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S1751090AbWB1WTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:19:12 -0500
Message-ID: <4404CC58.2020805@atl.lmco.com>
Date: Tue, 28 Feb 2006 17:19:04 -0500
From: Gautam H Thaker <gthaker@atl.lmco.com>
Organization: Lockheed Martin -- Advanced Technology Laboratories
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: Gautam H Thaker <gautam.h.thaker@lmco.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp
 vs. 2.6.12-1.1390_FC4
References: <43FE134C.6070600@atl.lmco.com> <20060228192738.GO4650@waste.org>
In-Reply-To: <20060228192738.GO4650@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Thu, Feb 23, 2006 at 02:55:56PM -0500, Gautam H Thaker wrote:
> 
>>The real-time patches at the URL below do a great job of endowing Linux with
>>real-time capabilities.
>>
>>http://people.redhat.com/mingo/realtime-preempt/
>>
>>It has been documented before (and accepted) that this patch turns Linux into
>>a RT kernel but considerably slows down the code paths, esp. thru the I/O
>>subsystem. I want to provide some additional measurements and seek opinions
>>of if it might ever be possible to improve on this situation.
> 
> 
> Are you using the SLAB or SLOB allocator in the -rt kernel?

lake> grep SL config.2.6.15-rt15-smp
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_SLAB=y
# CONFIG_SLOB is not set




-- 

Gautam H. Thaker
Distributed Processing Lab; Lockheed Martin Adv. Tech. Labs
3 Executive Campus; Cherry Hill, NJ 08002
856-792-9754, fax 856-792-9925  email: gthaker@atl.lmco.com
