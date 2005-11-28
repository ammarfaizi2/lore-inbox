Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVK1FBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVK1FBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 00:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVK1FBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 00:01:16 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:26104 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751233AbVK1FBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 00:01:16 -0500
Message-ID: <438A8F0F.2080205@lwfinger.net>
Date: Sun, 27 Nov 2005 23:01:03 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: thockin@hockin.org
CC: linux-kernel@vger.kernel.org
Subject: Re: What are the general causes of frozen system?
References: <43891D97.4000404@lwfinger.net> <20051127025221.GA30646@hockin.org> <43892281.8000601@lwfinger.net> <20051127031115.GA31651@hockin.org>
In-Reply-To: <20051127031115.GA31651@hockin.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thockin@hockin.org wrote:
> On Sat, Nov 26, 2005 at 09:05:37PM -0600, Larry Finger wrote:
> 
>>>Look for lock-related deadlocks.  Try turning on the nmi watchdog
>>
>>Thanks for the quick response. Unfortunately, adding either 
>>nmi_watchdog=1 or 2 makes my machine lockup in booting - just after ACPI 
>>is initialized.
> 
> 
> Try with acpi=off, too?
> 

It turned out that an 'lacpi' was causing the boot lockup. I tried all 
combinations of acpi on/off and nmi_watchdog 1/2 without any success. 
The NMI count in /proc/interrupts remains stuck at 0.
