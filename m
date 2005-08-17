Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVHQOJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVHQOJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 10:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVHQOJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 10:09:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:14537 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751126AbVHQOJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 10:09:10 -0400
Date: Wed, 17 Aug 2005 07:07:57 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <4302F098.11683.53787EA@rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.62.0508170706030.14139@schroedinger.engr.sgi.com>
References: <1124151001.8630.87.camel@cog.beaverton.ibm.com>
 <4302F098.11683.53787EA@rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005, Ulrich Windl wrote:

> whatever the implementation is, at some point there must exist an interface go get 
> and set "normal time", free of any jumps and jitter. That "frontend time" will be 
> used a a base of correction. Basically that means time should be as monotonic and 
> jitter free as possible for any measurement interval you like.

The interpolator provides such a time as xtime + offset and will self-tune 
to be as accurate as possible given fluctuations of the timer interrupt. 
It will even adapt to NTP interval variations.
