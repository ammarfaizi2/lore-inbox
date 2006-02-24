Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWBXTZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWBXTZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 14:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWBXTZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 14:25:55 -0500
Received: from mail.atl.external.lmco.com ([192.35.37.50]:21161 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S932432AbWBXTZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 14:25:54 -0500
Message-ID: <43FF5DBE.1080905@atl.lmco.com>
Date: Fri, 24 Feb 2006 14:25:50 -0500
From: Gautam H Thaker <gthaker@atl.lmco.com>
Organization: Lockheed Martin -- Advanced Technology Laboratories
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Gautam H Thaker <gautam.h.thaker@lmco.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp
 vs. 2.6.12-1.1390_FC4
References: <43FE134C.6070600@atl.lmco.com> <20060224165209.GC22097@thunk.org>
In-Reply-To: <20060224165209.GC22097@thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Thu, Feb 23, 2006 at 02:55:56PM -0500, Gautam H Thaker wrote:
> 
>>The real-time patches at the URL below do a great job of endowing Linux with
>>real-time capabilities.
>>
>>http://people.redhat.com/mingo/realtime-preempt/
> 
> 
> Gautam,
> 
> #1) Can you publish the code you used in your tests?

This may not be easy for me but I will try to get corp. approval(s).
Basically, the process that is, at least according to "top", showing ~5x
increased CPU usage is receiving very short UDP packets over a gigabit
interface at the rate of about 38,000 per second. UDP packets are small and
according to "/sbin/ifconfig" there are no errors, drops, overruns, frame or
carrier errors or collisions. (it is an isolated network of 20 PC3000s (3 GH
Xeon processors) at www.emulab.net.

> 
> #2) Can you post your .config file?  In particular, did you have any
> of the latency measurement options or other debugging options?  

The config file I had used to build the "RT" kernel can be found at:

http://www.atl.external.lmco.com/projects/QoS/config.2.6.15-rt15-smp

I had tried to have all debug options off

> 
> Regards,
> 
> 					- Ted


Gautam

-- 

Gautam H. Thaker
Distributed Processing Lab; Lockheed Martin Adv. Tech. Labs
3 Executive Campus; Cherry Hill, NJ 08002
856-792-9754, fax 856-792-9925  email: gthaker@atl.lmco.com
