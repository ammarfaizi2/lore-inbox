Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbUL2JLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbUL2JLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 04:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbUL2JLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 04:11:36 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:7344 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261328AbUL2JLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 04:11:24 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 and speedtouch usb
Date: Wed, 29 Dec 2004 10:11:21 +0100
User-Agent: KMail/1.6.2
Cc: Serge Tchesmeli <zztchesmeli@echo.fr>
References: <200412271108.47578.zztchesmeli@echo.fr>
In-Reply-To: <200412271108.47578.zztchesmeli@echo.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412291011.21931.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Hi Serge, please turn on the kernel config option CONFIG_USB_DEBUG.  Also, change

/*
#define DEBUG
#define VERBOSE_DEBUG
*/

to

#define DEBUG
/*
#define VERBOSE_DEBUG
*/

in drivers/usb/atm/speedtch.c and drivers/usb/atm/usb_atm.c.  You should then
get a bunch of stuff in your system logs.

Ciao,

Duncan.
