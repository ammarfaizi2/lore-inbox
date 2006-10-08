Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWJHSv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWJHSv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWJHSv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:51:57 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:8090 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751335AbWJHSv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:51:56 -0400
Message-ID: <452948AD.8030600@gmail.com>
Date: Sun, 08 Oct 2006 21:51:25 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: "raise.sail@gmail.com" <raise.sail@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>, greg <greg@kroah.com>,
       Randy Dunlap <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] usb/hid: The HID Simple Driver	Interface
 0.3.2 (core)
References: <200609291624123283320@gmail.com>		<20060929095913.f1b6f79d.rdunlap@xenotime.net>	<d120d5000609291035q7dad5f7fqcb38d4d8b3b211e5@mail.gmail.com> <45286B85.90402@gmail.com>
In-Reply-To: <45286B85.90402@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I didn't get Dmitry's original mail, so replying here)

raise.sail@gmail.com wrote:
> Dmitry Torokhov wrote:
>> Then there is issue with automatic loading of these sub-drivers. How
>> do they get loaded? Or we force everything to be built-in making HID
>> module very fat (like psmouse got pretty fat, but with HID prtential
>> for it to get very fat is much bigger).
>>
>> The better way would be to split hid-input into a library module that
>> parses hid usages and reports and is shared between device-specific
>> modules that are "real" drivers (usb-drivers, not hid-sub-drivers).

One possibility is to do that with symbol_request() and friends. That
would not be pretty though, imho.

DVB subsystem uses that currently to load frontend modules dynamically,
see dvb_attach() and dvb_frontend_detach() in
drivers/media/dvb/dvb-core/dvbdev.h and
drivers/media/dvb/dvb-core/dvb_frontend.c.

-- 
Anssi Hannula

