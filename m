Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVCDCSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVCDCSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVCDCSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:18:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:50683 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262866AbVCDCK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:10:58 -0500
Message-ID: <4227C3AA.6090505@mvista.com>
Date: Thu, 03 Mar 2005 18:10:50 -0800
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com> <20050302085619.GA1364@elf.ucw.cz> <42263719.7030004@mvista.com> <20050302221150.GE1616@elf.ucw.cz> <422659B1.9090608@mvista.com> <20050303145522.GA3485@openzaurus.ucw.cz>
In-Reply-To: <20050303145522.GA3485@openzaurus.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
...
>>In most of the cases I'm thinking of, it wouldn't be a user 
>>requesting a state but rather software (say, a cell phone 
>>progressively entering lower power states due to inactivity).  I 
>>haven't noticed a platform with more than 3 low-power modes so far, 
> 
> 
> Are not your power states more like cpu power states?
> These are expected to be system states, and sleeping system
> does not take calls, etc...

There's a great variety of behaviors and usage models out there, not 
sure I can draw a useful distinction between cpu power states vs. system 
states, but the net effect could be considered to be approximately the 
same in typical embedded uses: the drivers are called to place 
appropriate devices in a low(er)-power state, various platform thingies 
are slowed or powered off, and the system stops waiting for something to 
wake it up.  In some cases the system does not wake up until an explicit 
user action (button press, etc.), but more commonly 
wake-on-device-activity (including ring from telephony unit) or 
time-based actions (including wake on alarm from event in user's 
datebook) is also wanted (rather like wake-on-LAN et al).  I don't think 
this would correspond well to hardware-managed CPU power states like 
ACPI C states, for example.  Thanks,


-- 
Todd
