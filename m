Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWJIWxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWJIWxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 18:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWJIWxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 18:53:31 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:8446 "EHLO
	pne-smtpout4-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751910AbWJIWx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 18:53:29 -0400
Message-ID: <452AD2D9.3090001@gmail.com>
Date: Tue, 10 Oct 2006 01:53:13 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: "raise.sail@gmail.com" <raise.sail@gmail.com>, greg <greg@kroah.com>,
       Randy Dunlap <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] usb/hid: The HID Simple Driver Interface
 0.3.2 (core)
References: <200609291624123283320@gmail.com> <45286B85.90402@gmail.com> <452948AD.8030600@gmail.com> <200610082342.26110.dtor@insightbb.com>
In-Reply-To: <200610082342.26110.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Sunday 08 October 2006 14:51, Anssi Hannula wrote:
>> (I didn't get Dmitry's original mail, so replying here)
>>
>> raise.sail@gmail.com wrote:
>>> Dmitry Torokhov wrote:
>>>> Then there is issue with automatic loading of these sub-drivers. How
>>>> do they get loaded? Or we force everything to be built-in making HID
>>>> module very fat (like psmouse got pretty fat, but with HID prtential
>>>> for it to get very fat is much bigger).
>>>>
>>>> The better way would be to split hid-input into a library module that
>>>> parses hid usages and reports and is shared between device-specific
>>>> modules that are "real" drivers (usb-drivers, not hid-sub-drivers).
>> One possibility is to do that with symbol_request() and friends. That
>> would not be pretty though, imho.
>>
>> DVB subsystem uses that currently to load frontend modules dynamically,
>> see dvb_attach() and dvb_frontend_detach() in
>> drivers/media/dvb/dvb-core/dvbdev.h and
>> drivers/media/dvb/dvb-core/dvb_frontend.c.
>>
> 
> Unfortunately this does not quite work when hid is built-in and the rest
> are modules :(
> 

How so? I see nothing obvious.

-- 
Anssi Hannula

