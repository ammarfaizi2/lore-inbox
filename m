Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbUJaUNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUJaUNo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 15:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUJaUNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 15:13:44 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:21700 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261427AbUJaUNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 15:13:40 -0500
Message-ID: <4185489B.5070604@comcast.net>
Date: Sun, 31 Oct 2004 12:18:35 -0800
From: Z Smith <plinius@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>	 <20041030222720.GA22753@hockin.org>	 <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>	 <1099176319.25194.10.camel@localhost.localdomain>	 <41843E10.1040800@comcast.net> <1099235990.16414.12.camel@localhost.localdomain>
In-Reply-To: <1099235990.16414.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> My X server seems to be running at about 4Mbytes, plus the frame buffer
> mappings which make it appear a lot larger. I wouldn't be suprised if
> half the 4Mb was pixmap cache too, maybe more.

At first sight that sounds like a plausible explanation, however
the facts in my case suggest something else is going on:

My laptop's framebuffer is only 800x600x24bpp VESA, or 1406kB.
But look at what X is doing:

root       632  6.1 17.5 22024 16440 ?       S    12:05   0:17 X :0

The more apps in use, the more memory is used, but at the moment
I've only got xterm, rxvt, thunderbird, xclock and xload. My wm is
blackbox which is using 5 megs.

Also, just curious but why would memory-mapped I/O be counted
in the memory usage anyway? Shouldn't there be a separate number
for framebuffer memory and the like?

> I've helped write tiny UI kits (take a look at nanogui for example) but
> they don't have the flexibility of X.

In my experience, most of the flexibility is not necessary for
97% of what I do, yet it evidently costs a lot in memory usage
and speed.

Zack
