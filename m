Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVBGRT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVBGRT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVBGRTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:19:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:59271 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261206AbVBGRTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:19:31 -0500
Message-ID: <42079ECB.2090706@osdl.org>
Date: Mon, 07 Feb 2005 09:00:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Domen Puncer <domen@coderock.org>
CC: Mikkel Krautz <krautz@gmail.com>, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling
 Interval
References: <20050207154424.GB4742@omnipotens.localhost> <42079052.1050904@osdl.org> <20050207171646.GB15840@nd47.coderock.org>
In-Reply-To: <20050207171646.GB15840@nd47.coderock.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Domen Puncer wrote:
> On 07/02/05 07:59 -0800, Randy.Dunlap wrote:
> 
>>>+static unsigned int hid_mousepoll_interval;
>>>+module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
>>
>>Why is it writable by root?  IOW, will writing a new value to it
>>change the operational value dynamically?
>>
>>Also, from the kernel-parameters.txt patch:
>>+	usbhid.mousepoll=
>>+		[USBHID] The interval at wich mice are to be polled at.
>>
>>(a) "which"
>>(b) drop one of the "at"s... either one.
> 
> 
> Is listing module parameters in kernel-parameters.txt the right thing
> to do? (There are lots of them, not many are listed)

It's currently the right thing to do, but some automated overhaul
sure would make sense.

> I see some options that might be better:
> - Kconfig magic which extracts module_param* and MODULE_PARM_DESC from
>   sources and appends them to help text.
> - a userspace script, that goes trough all modules and generates
>   kernel-module-parameters.txt for example.
> - modinfo like tool (but i think it would require source or descriptions
>   compiled in kernel)

-- 
~Randy
