Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030843AbWKUKtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030843AbWKUKtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030845AbWKUKtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:49:43 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:52704 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030843AbWKUKtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:49:42 -0500
Message-ID: <4562D9BE.6030604@gmail.com>
Date: Tue, 21 Nov 2006 11:49:34 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kobject_add failed with -EEXIST
References: <4561E290.7060100@gmail.com> <20061120172733.GA26713@suse.de> <4561E68E.7040007@gmail.com> <20061120175209.GA27255@suse.de>
In-Reply-To: <20061120175209.GA27255@suse.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Nov 20, 2006 at 06:31:58PM +0100, Jiri Slaby wrote:
>> Greg KH wrote:
>>> On Mon, Nov 20, 2006 at 06:14:56PM +0100, Jiri Slaby wrote:
>>>> DEV: Unregistering device. ID = 'cls_device'
>>>> PM: Removing info for No Bus:cls_device
>>>> device_create_release called for cls_device
>>>> device class 'cls_class': unregistering
>>>> class 'cls_class': release.
>>>> class_create_release called for cls_class
>>>> cls_exit
>>> What does sysfs look like at this point in time?  Does
>>> /sys/class/cls_class exist?
>> No, there is no such dir (it disappears).
>>
>>> Also, which kernel version are you using here?
>> 2.6.19-rc6, 2.6.19-rc5-mm2
> 
> I can't duplicate this here at all with your example code.  Check
> userspace to see if HAL or your udev scripts are doing something
> "odd"...
> 
> What distro is this, and what version of HAL and udev are you using?

I'm not sure, if you get these?
http://lkml.org/lkml/2006/11/20/168
http://lkml.org/lkml/2006/11/20/197

I tried init=/bin/bash with no effect. 2.6.19-rc6 and 2.6.19-rc5-mm2 are on FC6,
2.6.19-rc5 is on some debian unstable (everything is mentioned in those links --
and my .config too).

$ rpm -q udev hal
udev-095-14
hal-0.5.8.1-4.fc6

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
