Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVC3Xb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVC3Xb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVC3Xb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:31:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:44700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262593AbVC3XbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:31:12 -0500
Message-ID: <424B36BC.2000005@osdl.org>
Date: Wed, 30 Mar 2005 15:31:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to debug kernel before there is no printk mechanism?
References: <424AD247.4080409@globaledgesoft.com> <Pine.LNX.4.61.0503301134240.28049@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0503301134240.28049@chaos.analogic.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Wed, 30 Mar 2005, krishna wrote:
> 
>> Hi all,
>>
>> How can one debug kernel before there is no printk mechanism in kernel.
>>
>> Regards,
>> Krishna Chaitanya

Here's an implementation by Keith Owens:
http://kernelnewbies.org/documents/videochar.txt

The patch there is to Linux 2.4.18, but should be workable
on many versions.

> Write directly to screen memory at 0x000b8000, or write to the
> RS-232C UART while polling the TX buf empty bit, or just write
> bits that mean something to you out the printer port.
> 
> Screen - memory is 16-bit words with the high-word being
> an attibute byte. FYI 0x07 is a good B&W byte. You can
> initialize a pointer to it as:
> 
> unsigned short *screen = 0xc00b8000; Since low memory
> is always mapped, the above cheat will work. The 0xc0000000
> is PAGE_OFFSET.
> 
> An early '486 was brought up into a 32-bit protected-mode
> (non linux) operating system using these debugging methods.
> The first time I got to see some symbol written to the
> screen in protected-mode marked the start of a week-end-
> long party. Have fun!


-- 
~Randy
