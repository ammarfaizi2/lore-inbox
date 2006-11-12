Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752153AbWKLSQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbWKLSQt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 13:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbWKLSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 13:16:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63244 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1752153AbWKLSQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 13:16:47 -0500
Date: Sun, 12 Nov 2006 14:49:40 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Trifon Trifonov <triffon@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmc0 power consumption
Message-ID: <20061112144939.GB4371@ucw.cz>
References: <45551135.7000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45551135.7000201@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  I would like to report an issue with my O2Micro 4-in-1 
>  Card reader. I am using kernel 2.6.17-10. Actually, the 
> device works properly (although it wasn't like that with 
> 2.6.15). I am just troubled by getting messages in the 
> syslog about the mmc0 device consuming too much power 
> after issuing ACPI suspend to RAM. I also don't have 

mmc controller is probably confused. Try unloading its driver before
suspend. reloading it after resume to see if it *really* eats more
power.

> obvious problems with suspending, except that after the 
> first suspend it will no longer suspend by closing the 
> lid, so I have to do this manually. Also, after the 

Either usb problem or acpi broken after resume. Verify that
/proc/acpi/events work after resume, report to bugzilla.kernel.org if
not.

> first suspend, statistics show that battery consumption 
> of my laptop seems to rise. So I suspect that something 
> isn't right with the suspend.

Well, on my x60 power consumption goes *down* after suspend,
suggesting something is wrong there, too... but finding what went
wrong is almost impossible.

Ouch, check with top for runaway threads.

						Pavel
-- 
Thanks for all the (sleeping) penguins.
