Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVAMDUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVAMDUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVAMDUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:20:07 -0500
Received: from mx.freeshell.org ([192.94.73.21]:25591 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261199AbVAMDTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:19:44 -0500
Date: Thu, 13 Jan 2005 03:19:21 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200501110239.33260.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0501130315500.11711@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <200501091102.51246.dtor_core@ameritech.net> <Pine.NEB.4.61.0501100107070.13360@sdf.lonestar.org>
 <200501110239.33260.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

I have placed the results of the patched 2.6.9-rc2-bk2 kernel at the 
following address:

   http://roey.freeshell.org/mystuff/kernel/*-20050112

As expected, the system was unresponsive to keyboard input.
Regarding your mouse question:
How do I test the mouse if they keyboard does not work (is there some 
way to output the contents of /dev/psaux on startup? I'm not sure anymore 
what file the mouse data appears in, too)

- Roey


On Tue, 11 Jan 2005, Dmitry Torokhov wrote:

> Date: Tue, 11 Jan 2005 02:39:33 -0500
> From: Dmitry Torokhov <dtor_core@ameritech.net>
> To: linux-kernel@vger.kernel.org
> Cc: Roey Katz <roey@sdf.lonestar.org>
> Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
> 
> On Sunday 09 January 2005 08:09 pm, Roey Katz wrote:
>> OK, I moved that input/serio line to be just above the line mentioning
>> "input".  Rebooted;  still got this error.  See all the -2.6.9-rc2-bk3
>> logs on my web site (http://roey.freeshell.org/mystuff/kernel/) for
>> details. I will follow up with psmouse disabled if you want.
>>
>
> I just don't see anything wrong with it... oh well...
>
> Ok, I have cut out everything but input changes from -rc2-bk3, could you
> pleasde try appying the patch below to -rc2. If it does not work it will
> prove that the input code is to blame and we'll start reverting changes
> one by one to find out the one that broke the keyboard.
>
> Make you are booting with log_buf_len=131072 as some of your logs are
> short. And be sure hit keyboard couple of times after the mox finished
> booting (single user mode preferably).
>
> Btw, does your mouse work?
>
>>
>> Roey
>> PS: just changing a Makefile makes a difference?
>>
> This particular chane make keyboard controller initialization code run later
> in the startup sequence, but apparently it had no visible effect.
>
> -- 
> Dmitry
>
>
