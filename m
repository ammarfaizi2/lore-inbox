Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935663AbWLFPS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935663AbWLFPS4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935644AbWLFPSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:18:55 -0500
Received: from styx.suse.cz ([82.119.242.94]:55045 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S935138AbWLFPSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:18:51 -0500
Date: Wed, 6 Dec 2006 16:18:54 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Li Yu <raise.sail@gmail.com>,
       Greg Kroah Hartman <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
In-Reply-To: <d120d5000612060713n5118b379w11dc7e65abae1c58@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612061615080.29624@jikos.suse.cz>
References: <200612061803324532133@gmail.com>  <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
  <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com> 
 <1165415924.2756.63.camel@localhost>  <Pine.LNX.4.64.0612061549040.29624@jikos.suse.cz>
 <d120d5000612060713n5118b379w11dc7e65abae1c58@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Dmitry Torokhov wrote:

> > I guess that this paragraph wasn't for me, but rather for the author of
> > the HID Simple Driver proposal, am I right?
> Yes, mainly for him but also for you because we need to be able to do
> what Li Yu is trying to do and be able to tweak HID interfaces.

I see. Will look at Li Yu's code to lear better what the Simple Driver 
Interface idea is about. Thanks.

> > This split is quite painful, as there are many things happening in USB all
> > the time, so the best way seem to be just to perform big split (with
> > needed changes) at once, and then develop other things on top of it (like
> > hidraw).
> Is there any reason why we can't mecanically move everything into 
> drivers/hid right now? Then Greg could simply forward all patches he 
> gets for HID your way and you won't have hard time merging your work 
> with others...

That definitely would be a possible solution.

In fact, the patches for the split I sent to you and a few other people 
two weeks ago or so, do exactly this - in some sense "mechanical" split of 
the generic parts laying currently in USB hid, from the USB-specific ones, 
and moving them around (sure, some changes are done, like introducing data 
structures specific to usbhid, etc., but no rocket science yet).

This would be nice to merge, if noone has any major objections, and do 
other development on top of that. 
I am currently trying to set up an account and git tree for this at 
kernel.org ... request sent, waiting for reply :)

Thanks,

-- 
Jiri Kosina
SUSE Labs
