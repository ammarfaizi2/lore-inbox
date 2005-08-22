Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVHVVYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVHVVYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVHVVYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:24:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53997 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751217AbVHVVYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:24:44 -0400
Date: Mon, 22 Aug 2005 08:26:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: sched_yield() makes OpenLDAP slow
In-reply-to: <Pine.LNX.4.61.0508220735370.18402@chaos.analogic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4309E07F.8010304@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4D8eT-4rg-31@gated-at.bofh.it> <4306A176.3090907@shaw.ca>
 <4306AF26.3030106@yahoo.com.au> <4307788E.1040209@symas.com>
 <4307D320.90902@shaw.ca> <Pine.LNX.4.61.0508220735370.18402@chaos.analogic.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> I reported thet sched_yield() wasn't working (at least as expected)
> back in March of 2004.
> 
>  		for(;;)
>                      sched_yield();
> 
> ... takes 100% CPU time as reported by `top`. It should take
> practically 0. Somebody said that this was because `top` was
> broken, others said that it was because I didn't know how to
> code. Nevertheless, the problem was not fixed, even after
> schedular changes were made for the current version.

This is what I would expect if run on an otherwise idle machine. 
sched_yield just puts you at the back of the line for runnable 
processes, it doesn't magically cause you to go to sleep somehow.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

