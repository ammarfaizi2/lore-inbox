Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVBQFNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVBQFNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 00:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVBQFNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 00:13:42 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:58039 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262215AbVBQFNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 00:13:40 -0500
Subject: Re: Swsusp, resume and kernel versions
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200502162346.26143.dtor_core@ameritech.net>
References: <200502162346.26143.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1108617332.4471.33.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 17 Feb 2005 16:15:32 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry.

On Thu, 2005-02-17 at 15:46, Dmitry Torokhov wrote:
> Pavel,
> 
> First of all I must say that swsusp has progressed alot and now works
> very reliably, at least for my configuration, and I use it a lot. Great
> job!
> 
> But I think there is one pretty severe issue present - even if swsusp
> is not enabled kernel should check if there is an image in swap and
> erase it. Today I has somewhat unpleasant experience - after suspending
> I accidentially loaded a vendor kernel. I was in hurry and decided that
> resume just failed for some reason so I did couple of things and left
> the box running. In the evening I realized that I am running vendor kernel
> and decided to reboot into my devel. version. What I did not expect is for
> the kernel to find a valid suspend image and restore it. As you might
> imagine messed up my disk somewhat.
> 
> Any chance this can be done?

One of my suspend2 users had the same thing yesterday. Unfortunately
there's no easy way for us to detect that another kernel has been
booted. The simplest solution we've found is to add commands in your
init scripts to mkswap the place where your image is stored when
rebooting. This will stop both of the implementations seeing the image
and resuming at a later time.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

