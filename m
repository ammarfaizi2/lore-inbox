Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVISWEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVISWEi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVISWEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:04:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:47241 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932470AbVISWEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:04:37 -0400
Date: Mon, 19 Sep 2005 15:03:58 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: tglx@linutronix.de
cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005 tglx@linutronix.de wrote:

> sources. Another astonishing implementation detail of the current time 
> keeping is the fact that we get the monotonic clock (defined by POSIX as 
> a continous clock source which can not be set) by subtracting a variable 
> offset from the real time clock, which can be set by the user and 
> corrected by NTP or other mechanisms.

The benefit or drawback of that implementation depends which time is more 
important: realtime or monotonic time. I think the most used time value is 
realtime and not monotonic time. Having the real time value in xtime 
saves one addition when retrieving realtime. 
