Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTJVTIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 15:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbTJVTIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 15:08:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:54664 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263494AbTJVTIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 15:08:11 -0400
Date: Wed, 22 Oct 2003 12:08:08 -0700
From: Dave Olien <dmo@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: rwhron@earthlink.net, venom@sns.it, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Mary Edie Meredith <maryedie@osdl.org>
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
Message-ID: <20031022190808.GA10311@osdl.org>
References: <20031021130501.GA4409@rushmore> <3F9653E6.4060209@cyberone.com.au> <20031022183028.GA10249@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031022183028.GA10249@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I don't know how useful this might but.  I've been trying to
track down which patches to as-iosched resulted in the performance
drop.  The results so far are a little confusing.  I have been
running reaim on an 8-way system, comparing as-iosched performance
with deadline, on each kernel version.  The numbers are "number
of jobs per minute".  So, larger is better.

			Deadline		As-iosched
2.6.0-test5   		8542			8589
2.6.0-test5-mm1		8303			8401
2.6.0-test5-mm2		8309			8224
2.6.0-test5-mm3		8222			8417
2.6.0-test6		8302			6934	****
2.6.0-test6-mm1		8375			8163
2.6.0-test6-mm2		???			8309

I'm still getting data on test6-mm*.  It's curious that
performance dropped for test6, but came back for test6-mm1.

On Wed, Oct 22, 2003 at 11:30:28AM -0700, Dave Olien wrote:
> 
> Sorry, this patch didn't fix our performance problems.  Mary just
> finished running dbt2 on test8 with your patch:
> 
> NOTPM   kernel          scheduler
> 965     2.6.0-test8-np  AS
> 1632    2.6.-test6-mm4  deadline
> 
> This is an 8-way system with DAC960 and 12 LUNs, using raw devices.
> That's still quite a sizeable drop.
> 
