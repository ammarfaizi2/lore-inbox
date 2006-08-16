Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWHPLKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWHPLKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 07:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHPLKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 07:10:39 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:39341 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750951AbWHPLKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 07:10:39 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH] PM: Use suspend_console in swsusp and make it configureable
Date: Wed, 16 Aug 2006 13:04:51 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz>
In-Reply-To: <20060816104143.GC9497@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161304.51758.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 16 August 2006 12:41, Pavel Machek wrote:
> Hi!
> 
> > The appended patch does the following:
> > 
> > 1) Adds suspend_console() and resume_console() to the suspend-to-disk code
> > paths so that people using netconsole are safe with swsusp.

So I assume this one is OK.

> > 2) Adds a Kconfig option allowing us to disable suspend_/resume_console()
> > if need be.
> 
> Slightly ugly, but I guess that is the way to go.

It also seems to be needed to add a 2 sec. dealy in suspend_console() so
that eg. the network console can send the messages before we try to suspend
the device.

> > 3) Marks CONFIG_PM_TRACE as dangerous.
> 
> I do not think that is enough. "(WILL TRASH YOUR CMOS)" would be more
> suitable. Dangerous is "may cause problems to you". This is "will
> cause problems to you". And for this to be useful, people have to edit
> sources, anyway.
> 
> 								Pavel
> 
> Can we just delete the config option?

OK, I'll do that.

I have divided the changes into three individual patches that will follow as
replies to this message.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

