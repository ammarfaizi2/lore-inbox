Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSKRHv1>; Mon, 18 Nov 2002 02:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSKRHv0>; Mon, 18 Nov 2002 02:51:26 -0500
Received: from holomorphy.com ([66.224.33.161]:53981 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261615AbSKRHv0>;
	Mon, 18 Nov 2002 02:51:26 -0500
Date: Sun, 17 Nov 2002 23:55:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.48
Message-ID: <20021118075547.GI23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021118065705.GG11776@holomorphy.com> <673851077.1037576831@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673851077.1037576831@[10.10.2.3]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, my attribution was stripped from this comment:
>> This oopses on NUMA-Q sometime prior to TSC synch and then hangs in TSC
>> synch because not all cpus are responding where 2.5.47-mm3 (which
>> included some intermediate bk stuff) did not. This is because AP's are
>> taking timer interrupts before they are prepared to do so. Please apply
>> the following patch from Martin Bligh which resolves this issue:

On Sun, Nov 17, 2002 at 11:47:12PM -0800, Martin J. Bligh wrote:
> It seems to come and go randomly (timing issue), it's not new with 48. 
> Has been happening since 44-mm3 or so. Just as a point of interest,
> doesn't seem to be the timer int itself that kill her, it's the 
> softirq processing that happens in irq_exit on the way back.

This is all the more ammunition for the patch's inclusion. Linus, this
problem is even more severe and more persistent than I originally reported.


Please apply.


Thanks,
Bill
