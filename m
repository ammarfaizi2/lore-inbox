Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVBQFie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVBQFie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 00:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVBQFie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 00:38:34 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:4010 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262218AbVBQFic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 00:38:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: ncunningham@cyclades.com
Subject: Re: Swsusp, resume and kernel versions
Date: Thu, 17 Feb 2005 00:38:29 -0500
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200502162346.26143.dtor_core@ameritech.net> <1108617332.4471.33.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1108617332.4471.33.camel@desktop.cunningham.myip.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502170038.30033.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

On Thursday 17 February 2005 00:15, Nigel Cunningham wrote:
> Hi Dmitry.
> 
> On Thu, 2005-02-17 at 15:46, Dmitry Torokhov wrote:
> > Pavel,
> > 
> > First of all I must say that swsusp has progressed alot and now works
> > very reliably, at least for my configuration, and I use it a lot. Great
> > job!
> > 
> > But I think there is one pretty severe issue present - even if swsusp
> > is not enabled kernel should check if there is an image in swap and
> > erase it. Today I has somewhat unpleasant experience - after suspending
> > I accidentially loaded a vendor kernel. I was in hurry and decided that
> > resume just failed for some reason so I did couple of things and left
> > the box running. In the evening I realized that I am running vendor kernel
> > and decided to reboot into my devel. version. What I did not expect is for
> > the kernel to find a valid suspend image and restore it. As you might
> > imagine messed up my disk somewhat.
> > 
> > Any chance this can be done?
> 
> One of my suspend2 users had the same thing yesterday. Unfortunately
> there's no easy way for us to detect that another kernel has been
> booted.

What do you mean? I thought it already compares signatures of the booting
kernel and suspend image. Just wipe it out if it does not match, or, even
better, just stop if signature does not match unless one boots with
"nosuspend". This way even if I start booting wrong image I have a chance
to select right one and avoid fsck.

-- 
Dmitry
