Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265115AbUFHAGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUFHAGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 20:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUFHAGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 20:06:53 -0400
Received: from web51810.mail.yahoo.com ([206.190.38.241]:59762 "HELO
	web51810.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265115AbUFHAGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 20:06:51 -0400
Message-ID: <20040608000650.81972.qmail@web51810.mail.yahoo.com>
Date: Mon, 7 Jun 2004 17:06:50 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <1086644098.40c4df826be23@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just to clarify, setting compute 1 implys interactive
0?

These numbers are very reproducable nad have done them
(in a continuous loop) for two hours.

The test is a make of headers for a propritary exec. 
Making headers is rather simple is all it does it link
a bunch of h files (traversing dirs) and some
dependance generation (3 files, yacc and lex).  I have
moved the source code base to local disk to dicount
nfs issues (though the difference is neglibible and
nfs performance on 2.6 is generally faster than 2.4).

I have tried to get a good test case that can be
submitted. Still trying. 

Any suggestions to try to diagnose this?

Thanks!
Phy
> > 
> Hi.
> 
> How repeatable are the numbers normally? Some idea
> of what it is you're
> benchmarking may also help in understanding the
> problem; locking may be an
> issue with what you're benchmarking and out-of-order
> scheduling is not as
> forgiving of poor locking. Extending the RR_INTERVAL
> and turning off
> interactivity makes it more in-order and more
> forgiving of poor locking or
> yield().
> 
> Compute==1 setting inactivates interactivity anyway,
> but that's not really
> relevant to your figures since you had set
> interactive 0 when you set compute
> 1.
> 
> Con
> 



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
