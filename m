Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUBQWet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUBQWel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:34:41 -0500
Received: from gprs159-87.eurotel.cz ([160.218.159.87]:17028 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266809AbUBQWdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:33:39 -0500
Date: Tue, 17 Feb 2004 23:33:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Carl Thompson <cet@carlthompson.net>
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: hard lock using combination of devices
Message-ID: <20040217223319.GB666@elf.ucw.cz>
References: <20040216214111.jxqg4owg44wwwc84@carlthompson.net> <200402170854.22973.vda@port.imtp.ilyichevsk.odessa.ua> <20040216231401.3ig4kksk4k8g8440@carlthompson.net> <200402171149.49985.vda@port.imtp.ilyichevsk.odessa.ua> <20040217061400.z9r4gss0gsockws4@carlthompson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217061400.z9r4gss0gsockws4@carlthompson.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>> Your box share IRQs in a big way :)
> >>
> >>Your point?
> >
> >While shared interrupts can in theory work right,
> >lots of hardware and/or drivers do not handle
> >that.
> 
> First, the two devices in question are not on the same interrupt.  Second, 
> it
> is very difficult in this day in age to build a system without interrupt
> sharing.  While I agree that it's better to have as few devices sharing as
> possible, there are simply too many devices in modern systems and too few
> interrupts.  Interrupt sharing needs to work on modern hardware and needs to
> work in Linux.  This notebook is pretty typical in its interrupt 
> distribution

>            CPU0       
>   0:   41027968          XT-PIC  timer
>   1:      26061          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   8:          1          XT-PIC  rtc
>   9:       2020          XT-PIC  acpi
>  10:    2187181          XT-PIC  yenta, driverloader
>  11:        111          XT-PIC  ALI 5451
>  12:    2399118          XT-PIC  i8042
>  14:     169829          XT-PIC  ide0
>  15:          1          XT-PIC  ide1
> NMI:          0 
> LOC:   41036749 
> ERR:     275764
> MIS:          0

Does that mean you are actually using windows driver for your wireless
card? At that point ... no wonder it breaks ;-).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
