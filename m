Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVK0DFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVK0DFm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 22:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVK0DFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 22:05:42 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:21151 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1750822AbVK0DFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 22:05:42 -0500
Message-ID: <43892281.8000601@lwfinger.net>
Date: Sat, 26 Nov 2005 21:05:37 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: thockin@hockin.org
CC: linux-kernel@vger.kernel.org
Subject: Re: What are the general causes of frozen system?
References: <43891D97.4000404@lwfinger.net> <20051127025221.GA30646@hockin.org>
In-Reply-To: <20051127025221.GA30646@hockin.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thockin@hockin.org wrote:
>>What should I consider as a cause of the freeze? I have reviewed the 
>>code and do not find any obvious out-of-bounds memory references. I have 
>>tried various 'printk' statements, but none of them in the bottom-half 
>>interrupt routine make it to the logs. Are there any tricks that I 
>>should try?
> 
> 
> Look for lock-related deadlocks.  Try turning on the nmi watchdog
> 

Thanks for the quick response. Unfortunately, adding either 
nmi_watchdog=1 or 2 makes my machine lockup in booting - just after ACPI 
is initialized.
