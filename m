Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270256AbTGRRWI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270262AbTGRRWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:22:07 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:21931 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S270256AbTGRRV4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:21:56 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: usb in 2.4.22-pre6?
Date: Fri, 18 Jul 2003 13:36:50 -0400
User-Agent: KMail/1.5.1
References: <200307160102.07774.gene.heskett@verizon.net>
In-Reply-To: <200307160102.07774.gene.heskett@verizon.net>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307181336.50624.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.62.27] at Fri, 18 Jul 2003 12:36:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 July 2003 01:02, Gene Heskett wrote:
>Greets everybody;
>
>I have a camera, a Logitech(Sunplus ccd chipset) ClickSmart 310, usb
>interface, that almost works with qcam-vc.  But I just noticed,
> after rebooting to 2.4.22-pre6 earlier today, that the display on
> the camera no longer is reporting 'PC', and that there are some
> messages that look like problems in dmesg.
>
>So my conclusion is that whatever has been adjusted in the usb
> stuffs, has now rendered the camera totally un-reachable.
>
>This would make life difficult as I'm currently in negotiations with
>the Sunplus folks on the left coast trying to get a data sheet on
> the chipset in it so that I might try to write a new driver for
> these.

A PS: to this one, clues if you will, to be added to the other info 
I've posted regarding a ClickSmart 310 camera, and the qcam-vc 
drivers.

I built a kernel with usb debugging turned on, which made it work.  
I'd also tried to build v4l into the kernel but that got an error 
exit, so I went back to making it as a module.  So with everything 
V4L related is as modules below.

The difference between the verbose usb debugging on/off apparently 
does something to the timeing.  With the debugging on, it works but 
the dmesg buffer is overrun so I don't get a full report only the 
tail end, and with the debugging turned back off and the kernel 
rebuilt, no other changes, then it fails, with these lines being 
logged in /var/log/dmesg:
--------
vid 0x04B8 pid 0x0005
host/usb-uhci.c: interrupt, status 2, frame# 1641
hub.c: usb_hub_port_status (2) failed (err = -84)
hub.c: connect-debounce failed, port 3 disabled
--------

And the device is not intitialized.

Is this a usefull clue?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

