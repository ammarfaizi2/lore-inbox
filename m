Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271158AbTHLSoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271159AbTHLSoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:44:23 -0400
Received: from pop.gmx.net ([213.165.64.20]:46008 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271158AbTHLSoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:44:21 -0400
Message-Id: <5.2.1.1.2.20030812203720.01a06b08@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 12 Aug 2003 20:48:17 +0200
To: Timothy Miller <miller@techsource.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: WINE + Galciv + 2.6.0-test3-mm1-O15
Cc: Con Kolivas <kernel@kolivas.org>, gaxt <gaxt@rogers.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3F39358D.5040506@techsource.com>
References: <3F38FCBA.1000008@rogers.com>
 <3F22F75D.8090607@rogers.com>
 <200307292246.36808.kernel@kolivas.org>
 <3F38FCBA.1000008@rogers.com>
 <5.2.1.1.2.20030812193758.0197b9c0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:44 PM 8/12/2003 -0400, Timothy Miller wrote:


>Mike Galbraith wrote:
>
>>That sounds suspiciously similar to my scenario, but mine requires a 
>>third element to trigger.
>><scritch scritch scritch>
>>What about this?  In both your senario and mine, X is running low on cash 
>>while doing work at the request of a client right?  Charge for it.
>>If X is lower on cash than the guy he's working for, pick the client's 
>>pocket... take the remainder of your slice from his sleep_avg for your 
>>trouble.  If you're not in_interrupt(), nothing's free.  Similar to 
>>Robinhood, but you take from the rich, and keep it :)  He's probably 
>>going straight to the bank after he wakes you anyway, so he likely won't 
>>even miss it.  Instead of backboost of overflow, which can cause nasty 
>>problems, you could try backtheft.
>
>
>How is this different from back-boost?

With backboost, you take everything that overflows MAX_SLEEP_AVG and give 
it all to the waker... you always pull-up.  With back-theft (blech;), 
there's constant pull-up and push-down for all parties instead of only 
those who reach MAX_SLEEP_AVG, so while you'll still tend to group tasks 
which are related (the original goal of backboost), it shouldn't (wild 
theory) go raging out of control.

         -Mike 

