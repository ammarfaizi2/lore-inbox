Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbUL2QSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUL2QSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 11:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbUL2QSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 11:18:38 -0500
Received: from thor.itep.ru ([194.85.69.254]:8350 "EHLO mail.itep.ru")
	by vger.kernel.org with ESMTP id S261368AbUL2QSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 11:18:36 -0500
Date: Wed, 29 Dec 2004 19:18:33 +0300
From: Roman Kagan <rkagan@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: Serge Tchesmeli <zztchesmeli@echo.fr>,
       Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: Re: 2.6.10 and speedtouch usb
Message-ID: <20041229161829.GA9076@panda.itep.ru>
References: <200412271108.47578.zztchesmeli@echo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412271108.47578.zztchesmeli@echo.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 04:04:21PM +0000, Serge Tchesmeli wrote:
> i have try the new kernel 2.6.10, compil with exactly the same option from my 
> 2.6.9 (i have copied the .config) but i notice a high load on my machine, and 
> i see that was syslogd.
> So, i look at my log and see:
> 
> Dec 26 19:40:44 gateway last message repeated 137 times
> Dec 26 19:40:46 gateway kernel: usb 2-1: events/0 timed out on ep0in
> Dec 26 19:40:46 gateway kernel: SpeedTouch: Error -110 fetching device status
> Dec 26 19:40:46 gateway kernel: usb 2-1: modem_run timed out on ep0in
> Dec 26 19:40:46 gateway kernel: usb 2-1: usbfs: USBDEVFS_CONTROL failed cmd 
> modem_run rqt 192 rq 18 len 8 ret -110
> Dec 26 19:40:46 gateway kernel: usb 2-1: usbfs: process 5296 (modem_run) did 
> not claim interface 0 before use
> Dec 26 19:40:49 gateway last message repeated 413 times
> Dec 26 19:40:51 gateway kernel: usb 2-1: events/0 timed out on ep0in
> Dec 26 19:40:51 gateway kernel: SpeedTouch: Error -110 fetching device status
> Dec 26 19:40:51 gateway kernel: usb 2-1: modem_run timed out on ep0in
> Dec 26 19:40:51 gateway kernel: usb 2-1: usbfs: USBDEVFS_CONTROL failed cmd 
> modem_run rqt 192 rq 18 len 8 ret -110
> Dec 26 19:40:51 gateway kernel: usb 2-1: usbfs: process 5296 (modem_run) did 
> not claim interface 0 before use
> Dec 26 19:40:59 gateway last message repeated 1105 times
> 
> The speedtouch modem work, connection is etablished and work well.

It looks like the line status monitoring implemented in the driver in
2.6.10 interferes with that in modem_run.  Unless you have a reason to
keep using modem_run, you can let it go and use the line status
monitoring and firmware loading facilities provided by the driver
itself.  Just follow Andrew's advice.

  Roman.
