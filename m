Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935111AbWKYBFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935111AbWKYBFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 20:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935112AbWKYBFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 20:05:50 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:60838 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S935111AbWKYBFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 20:05:49 -0500
Date: Fri, 24 Nov 2006 19:05:44 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Signals and threads
In-reply-to: <1164362486.344548.309830@45g2000cws.googlegroups.com>
To: shibu-kundara <thomasece@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <456796E8.6010409@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1164362486.344548.309830@45g2000cws.googlegroups.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shibu-kundara wrote:
>     Hi
> 
> I have a problem using sigaction function in pthread library.
> I have 2 thread each one registering
> 
> in threadA
>  act1.sa_handler=func1;
>  if(sigaction(SIGUSR1,&act1,NULL)) printf("\nSigaction failed! in th1
> !!\n");
> 
> in threadB
>  act1.sa_handler=func2;
>  if(sigaction(SIGUSR1,&act2,NULL)) printf("\nSigaction failed! in th2
> !!\n");
> 
> but when i send signal SIGUSR1 to threadA , threadA  receives the
> signal
> but the handler func2 is getting called,
> 
> 
> Please let me know is there any way to solve this problem?
> thanks in advance
> thomas
> 

Signal handlers are global to the process. You can't create different 
handlers for the same signal in multiple threads.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

