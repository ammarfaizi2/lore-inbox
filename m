Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbULRC1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbULRC1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 21:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbULRC1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 21:27:17 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:3233 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261164AbULRC1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 21:27:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ClMHt3FFrldBlN1Cuwt97M3RondPEIfEkB+BV1mJ/nq5Cd5xmH8PjXblUUcdxo+qrSSvYEjUTRN4k42E3NUeU7LmWZXaE89FvJXavTU+kmnscsU3tDVp/7MpHKBNpxfzbGAbDIYYzFDNLOUoy4URSkOcBAbJAvOo7DcnBhwjWvI=
Message-ID: <41C3B546.2040105@gmail.com>
Date: Sat, 18 Dec 2004 04:42:46 +0000
From: Mikkel Krautz <krautz@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling
 Interval
References: <1103335970.15567.15.camel@localhost> <20041218012725.GB25628@kroah.com>
In-Reply-To: <20041218012725.GB25628@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Sat, Dec 18, 2004 at 02:12:50AM +0000, Mikkel Krautz wrote:
>  
>
>>Hi!
>>
>>This patch adds the option "USB HID Mouse Interrupt Polling Interval"
>>to drivers/usb/input/Kconfig, and a few lines of code to
>>drivers/usb/input/hid-core.c, to make the config option function.
>>
>>It allows people to change the interval, at which their USB HID mice
>>are polled at. This is extremely useful for people who require high
>>precision, or just likes the feeling of a very precise mouse. ;)
>>
>>As the Kconfig help implies, setting a lower polling interval is known
>>to work on several mice produced by Logitech and Microsoft. I only
>>have a Logitech MX500 to test it on. My results have been positive,
>>and so have many other people's.
>>    
>>
>
>Why not just make it a sysfs file, so you can tune it per device?  That
>way you also don't have to make it a Kconfig option.
>
>thanks,
>
>greg k-h
>
>  
>
I'm not too familiar with sysfs, so I really don't know.

The interval is set when the device is configured - that's only once.

Therefore I think a static value in Kconfig is fine. Wouldn't a sysfs 
entry be a little overkill for this?


Mikkel Krautz

