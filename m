Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWGaTtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWGaTtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWGaTtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:49:55 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:25505
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751270AbWGaTtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:49:53 -0400
Message-ID: <44CE5EE0.3090605@ed-soft.at>
Date: Mon, 31 Jul 2006 21:49:52 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Edgar Hucek <hostmaster@ed-soft.at>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
Subject: Re: [PATCH 1/3] add-imacfb-docu-and-detection.patch
References: <44CDBE5D.8020504@ed-soft.at> <20060731193254.GA31594@nineveh.rivenstone.net>
In-Reply-To: <20060731193254.GA31594@nineveh.rivenstone.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Fannin schrieb:
> On Mon, Jul 31, 2006 at 10:25:01AM +0200, Edgar Hucek wrote:
>> This Patch add basic Machine detection to imacfb and
>> some Ducumentation bits for imacfb.
> 
>> +Imacfb does not have any kind of autodetection of your machine.
>> +You have to add the fillowing kernel parameters in your elilo.conf:
>> +	Macbook :
>> +		video=imacfb:macbook
>> +	MacMini :
>> +		video=imacfb:mini
>> +	Macbook Pro 15", iMac 17" :
>> +		video=imacfb:i17
>> +	Macbook Pro 17", iMac 20" :
>> +		video=imacfb:i20
> 
>> -	/* ignore error return of fb_get_options */
>> -	fb_get_options("imacfb", &option);
>> +	if (!efi_enabled)
>> +		return -ENODEV;
>> +	if (!dmi_check_system(dmi_system_table))
>> +		return -ENODEV;
>> +	if (model == M_UNKNOWN)
>> +		return -ENODEV;
> 
>     So imacfb now defaults to off?  That would be good, especially
> since it cannot be a module, and doesn't work with the Apple "BIOS"
> stuff.
> 
>     If not, a video=imacfb:off option would be much appreciated.

Yes. Imacfb only works when efi an efi boot is detected and a supported
Apple device is found.

cu

Edgar Hucek

> --
> Joseph Fannin
> jfannin@gmail.com
> 
> 

