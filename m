Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVFWXmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVFWXmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVFWXmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:42:36 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:15085 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262578AbVFWXkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:40:14 -0400
Date: Thu, 23 Jun 2005 17:39:13 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Possible spin-problem in nanosleep()
In-reply-to: <4iz0p-5fH-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42BB4821.8040308@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4iz0p-5fH-7@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Is this a known problem? Is it going to be fixed? In a possibly
> related note, the following:
> 
> main()
> {
>     for(;;)
>         sched_yield();
> }
> 
> .... is shown to be spinning, by 'top' not sleeping. This, even though
> it is giving up its quantum continuously.

If no other processes are runnable, this will still use 100% of the CPU.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

