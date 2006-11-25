Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935053AbWKYA3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935053AbWKYA3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 19:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935097AbWKYA3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 19:29:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:27573 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S935053AbWKYA3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 19:29:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=uApF8gf7i/mIiXt9rhTVY62j8lDuv56N5xs04tR72AHuPhra0c6Vk7u9JSa3OB+fIbaWSYlf6Z89LxY/VfcxM/swHyWXni2hdprAyp/PqKEIIWehOrzvaR5dGPJfpiudoydXDWXjpuLFGKt9EI0w+pob/xr5Ddt8Jjc9H+WhCYk=
Message-ID: <45678E76.7070106@gmail.com>
Date: Sat, 25 Nov 2006 01:29:19 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: kobject_add failed with -EEXIST
References: <4561E290.7060100@gmail.com> <20061120172733.GA26713@suse.de>	 <4561E68E.7040007@gmail.com> <20061120175209.GA27255@suse.de> <4af2d03a0611241620h657de9b8jfb9310e19f68f426@mail.gmail.com>
In-Reply-To: <4af2d03a0611241620h657de9b8jfb9310e19f68f426@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Nov 20, 2006 at 06:31:58PM +0100, Jiri Slaby wrote:
>> Greg KH wrote:
>> > On Mon, Nov 20, 2006 at 06:14:56PM +0100, Jiri Slaby wrote:
>> >> DEV: Unregistering device. ID = 'cls_device'
>> >> PM: Removing info for No Bus:cls_device
>> >> device_create_release called for cls_device
>> >> device class 'cls_class': unregistering
>> >> class 'cls_class': release.
>> >> class_create_release called for cls_class
>> >> cls_exit
>> >
>> > What does sysfs look like at this point in time?  Does
>> > /sys/class/cls_class exist?
>>
>> No, there is no such dir (it disappears).
>>
>> > Also, which kernel version are you using here?
>>
>> 2.6.19-rc6, 2.6.19-rc5-mm2
> 
> I can't duplicate this here at all with your example code.  Check
> userspace to see if HAL or your udev scripts are doing something
> "odd"...
> 
> What distro is this, and what version of HAL and udev are you using?

2 x FC6 (2.6.19-rc6, 2.6.19-rc5-mm2) and some unstable debian (2.6.19-rc5).
$ rpm -q udev hal
udev-103-2
hal-0.5.8.1-4.fc6

$ dpkg-query -W udev hal
udev    0.100-2.1
hal     0.5.8.1-1

Not even init=/bin/bash helps (userspace doesn't seem to be involved).
Do you need some other info?
I don't know, if you got my previous e-mail, could you confirm this one?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
