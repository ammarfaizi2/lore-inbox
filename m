Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTFKVXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264447AbTFKVXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:23:18 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:12209 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264533AbTFKVXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:23:09 -0400
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz, discuss@x86-64.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1055366609.18643.63.camel@w-jstultz2.beaverton.ibm.com>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
	 <20030611191815.GA30411@wotan.suse.de>
	 <1055361411.17154.83.camel@serpentine.internal.keyresearch.com>
	 <1055362249.17154.86.camel@serpentine.internal.keyresearch.com>
	 <1055366609.18643.63.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1055367412.17154.100.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jun 2003 14:36:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 14:23, john stultz wrote:

> Hmmm. Thats likely part to blame for the lost-ticks code not working. I
> believe tick_usec is calculated USER_HZ rather then HZ, so you'll be off
> by an order of magnitude. I ran into the exact same problem. 

Unlikely.  On my systems, the offset values are off by three orders of
magnitude, and are always negative.  There's a more basic error
somewhere before that test.

The actual impact of lost jiffies is pretty low, though.  I've beaten
vigorously on my systems with the time patch, and they don't lose timer
interrupts.

	<b

