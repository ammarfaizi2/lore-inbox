Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbWF1BFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbWF1BFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 21:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWF1BFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 21:05:12 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:11670 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932651AbWF1BFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 21:05:10 -0400
Message-ID: <44A1D5E5.3020903@acm.org>
Date: Tue, 27 Jun 2006 20:05:41 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: add pretimeout ioctl
References: <20060627182225.GD10805@localdomain> <1151434785.32186.56.camel@localhost.localdomain>
In-Reply-To: <1151434785.32186.56.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-06-27 am 13:22 -0500, ysgrifennodd minyard@acm.org:
>   
>> Some watchdog timers support the concept of a "pretimeout" which
>> occurs some time before the real timeout.  The pretimeout can
>> be delivered via an interrupt or NMI and can be used to panic
>> the system when it occurs (so you get useful information instead
>> of a blind reboot).
>>     
>
> All watchdogs can do pre-timeouts in software so possibly this should
> use a software fallback as well if you want good coverage ?
>   
I hadn't thought of that, but a software emulator could be used with
this interface, but it doesn't really help with hard lockups.  This is
primarily intended to set up watchdogs that can delver an NMI,
since even if the machine is hard-locked the NMI will come through.
Of course, there's all kinds of problems with getting the NMI to a
useful handler, but that's another story.

-Corey
