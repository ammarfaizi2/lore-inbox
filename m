Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWBWLWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWBWLWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 06:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWBWLWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 06:22:37 -0500
Received: from fmr20.intel.com ([134.134.136.19]:21476 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750804AbWBWLWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 06:22:37 -0500
Message-ID: <43FD9AEF.1040204@linux.intel.com>
Date: Thu, 23 Feb 2006 12:22:23 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/3] fast VMA recycling
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <200602231105.30581.ak@suse.de> <1140689706.4672.28.camel@laptopd505.fenrus.org> <200602231200.42990.ak@suse.de>
In-Reply-To: <200602231200.42990.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> see voluntary preempt.
> 
> Only when its time slice is used up 

or if some other thread gets a higher dynamic prio
> but then it would sleep a bit later 
> in user space. 

... but that is without the semaphore held! (and that is the entire 
point of this patch, move the sleep moments to outside the lock holding 
area as much as possible, to reduce lock hold times)


