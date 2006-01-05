Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWAEXtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWAEXtD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWAEXtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:49:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46266 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751426AbWAEXtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:49:00 -0500
Date: Fri, 6 Jan 2006 00:05:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Preece Scott-PREECE <scott.preece@motorola.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, akpm@osdl.org,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105230556.GM2095@elf.ucw.cz>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD85@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD85@de01exm64.ds.mot.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 05-01-06 17:55:33, Preece Scott-PREECE wrote:
> I shouldn't oversimplify the power management in a cell phone. When I said we turned whole devices on/off, I was referring only to what the system-level PM (which uses suspend/resume) does. There's a fair amount of subsystem-specific power management outside the Linux suspend/resume framework. Some of it might be handled in the framework, if the framework were more capable.
> 

Ok, system-level PM is not interesting in this discussion.

You do runtime-powermanagement of devices, right? Let's take display
as an example.

(1) Do you have multiple display states like

on-fast: can refresh image every 10msec

on-slow: can only refresh image once per second, but takes less power

?

(2) Do you have multiple display states like

off-fast: display is off, user can not see anything, but it only takes
msec to wake up

off-slow: it takes 1 second for display to wake up, but it takes less
power

?

[Maybe display is bad example, but I can't think of better device with
complex power management]

								Pavel

> scott
> 
> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz] 
> Sent: Thursday, January 05, 2006 4:46 PM
> To: Preece Scott-PREECE
> Cc: Alan Stern; akpm@osdl.org; linux-pm@lists.osdl.org; linux-kernel@vger.kernel.org
> Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
> 
> On Čt 05-01-06 17:21:38, Preece Scott-PREECE wrote:
> > We do have multiple system-level low-power modes. I believe today they 
> > differ in turning whole devices on or off, but there are some of those 
> > devices that could be put in reduced-function/lowered-speed modes if 
> > we were ready to use a finer-grained distinction.
> 
> I think we were talking multiple off modes for _single device_. It is good to know that even cellphones can get away with whole devices on/off today.
> 								Pavel
> 
> --
> Thanks, Sharp!

-- 
Thanks, Sharp!
