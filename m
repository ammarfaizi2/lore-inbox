Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968809AbWLGFZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968809AbWLGFZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968811AbWLGFZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:25:23 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:48020 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968809AbWLGFZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:25:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iYSZKTbSn6gY47hVvy2UKGth9UfKp9evffHtiMdpllog28j0mVun2sfeU4F0XyCF+eZBQFNhS1qxu8xqJiTW8VV9AVQyKsRiJu3/zOf9mq+k0QYjgbXUgfkjUnLapt328qjI7VGAqFiVwcbkRfnrb8gTF35wuE7W1sP8w/upoys=
Message-ID: <4577A5C4.90703@gmail.com>
Date: Thu, 07 Dec 2006 13:25:24 +0800
From: Liyu <raise.sail@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jiri Kosina <jkosina@suse.cz>
CC: Li Yu <raise.sail@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Greg Kroah Hartman <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>,
       Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
References: <200612061803324532133@gmail.com> <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina wrote:
> Do you think that you could wait a little bit more, after the split has 
> been done? (it's currently planned approximately after 2.6.20-rc1). It 
> seems to me that your patches will apply almost cleanly on top of the 
> split patches (you will have to change the pathnames, of course).  
Of course, I interest to wait this. If they have other weakless, tell me
too.
I also think the HID split plan is a great idea.

Dmitry wrote:
> I still have the same objection - the "simple'" code will have to be
> compiled into the driver instead of being a separate module and
> eventyally will lead to a monster-size HID module. We have this issue
> with psmouse to a degree but with HID the growth potential is much
> bigger IMO.

As you guess;), I do not agree with your words very much. We can image,
there
are many devices use some HID base layer, however they even do not merge
into
mainstream kernel source tree for some reasons. and in fact, I do not
like the
mainstream kernel source tree include every drivers. For such devices
out of core,
we should have such feature that let developer write such driver
quickly. I think
it allows many monster-size driver modules is a better means than
all-in-one.But we
need resolve /dev/input/event? switching problem in principle first,
else we still
encounter same problem when new hidraw come.

Good luck.

-Li Yu
www.co-create.com.cn

