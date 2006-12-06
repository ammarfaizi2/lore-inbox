Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760452AbWLFKZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760452AbWLFKZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 05:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760456AbWLFKZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 05:25:10 -0500
Received: from twin.jikos.cz ([213.151.79.26]:42313 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760452AbWLFKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 05:25:08 -0500
Date: Wed, 6 Dec 2006 11:24:35 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To: Li Yu <raise.sail@gmail.com>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Greg Kroah Hartman <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>,
       Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
In-Reply-To: <200612061803324532133@gmail.com>
Message-ID: <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
References: <200612061803324532133@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Li Yu wrote:

> 	1. Make hidinput_disconnect_core() be more robust, it can not 
>          break anything even failed to allocate device struct.
> 	2. Thanks new input device driver API, we need not the extra code 
>          for support force-feed device yet, so say bye to 
>          CONFIG_HID_SIMPLE_FF.
> Is this ready to merge? or What still is problem in them? Thanks.

Hi,

actually, I have prepared patches to split the USBHID code in two parts - 
generic HID, which could be hooked by transport-specific HID layers (USB, 
Bluetooth). 

I did not send them to lkml/linux-usb, as they are quite big (mainly 
because a lot of code is being moved around). I am currently trying to 
setup a git repository on kernel.org, hopefully kernel.org people will 
react, so that the patches could be easily put into git repository and be 
available for rewiew and easy merge. After that, they are planned to be 
merged either into Greg's or Andrew's tree. I can send them to you if you 
want.

Do you think that you could wait a little bit more, after the split has 
been done? (it's currently planned approximately after 2.6.20-rc1). It 
seems to me that your patches will apply almost cleanly on top of the 
split patches (you will have to change the pathnames, of course).

Thanks,

-- 
Jiri Kosina
SUSE Labs

