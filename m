Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbUB1DjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 22:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbUB1DjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 22:39:25 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:45975 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263116AbUB1DjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 22:39:23 -0500
Message-ID: <40400D6B.4050003@backtobasicsmgmt.com>
Date: Fri, 27 Feb 2004 20:39:23 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Robbins <drobbins@gentoo.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-bk9 QA testing: firewire good, USB printing dead
References: <1077933682.14653.23.camel@wave.gentoo.org>	 <20040228021040.GA14836@kroah.com> <1077937052.14653.40.camel@wave.gentoo.org>
In-Reply-To: <1077937052.14653.40.camel@wave.gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Robbins wrote:

> Feb 27 10:52:44 [kernel] drivers/usb/class/usblp.c: usblp0: error -71 reading printer status
>                 - Last output repeated 1140 times -

I have this identical problem using a 2.6.3-bk snapshot from a few days 
ago. My hardware is a Samsung ML-2150 printer (USB 2 High Speed) 
connected to a VIA EHCI embedded in my VIA KT-600 chipset.

I sent a four page print job through CUPS; during page 4, the printer 
timed out, and the CUPS "usb" process was hung and would not respond to 
any signals (not even -9). When I unplugged the printer's USB cable, the 
"usb" process died, and my syslog reported these error messages (but not 
before I unplugged the cable). In my case I had 3,458 of them.

Plugging the printer back in, usblp re-registered it, so I tried sending 
a job again, but could not get any data to flow to the printer without 
restarting the Linux system.
