Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVGaMVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVGaMVS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 08:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVGaMVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 08:21:18 -0400
Received: from [195.144.244.147] ([195.144.244.147]:5094 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S261710AbVGaMVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 08:21:17 -0400
Message-ID: <42ECC230.7070004@varma-el.com>
Date: Sun, 31 Jul 2005 16:21:04 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Where is place of arch independed companion
 chips?
References: <42EB6A12.70100@varma-el.com> <42EC5659.7010300@gmail.com>
In-Reply-To: <42EC5659.7010300@gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Antonino A. Daplas wrote:
> Andrey Volkov wrote:
> 
>> Hi Greg,
>>
>> While I write driver for SM501 CC (which have graphics controller, USB
>> MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
>> I bumped with next ambiguity:
>> Where is a place of this chip's Kconfig/drivers in
>> kernel config/drivers tree? May be create new node in drivers subtree?
>> Or put it under graphics node (since it's main function of this CC)?
> 
> 
> You will have to split your driver (graphics under drivers/video, usb
> under drivers/usb, ac97 under sound, video capture under drivers/media,
> etc.
Yes, it was first what I try, BUT - all these drivers have common
code (as bus driver, in my case) and some of private headers.
And problem exactly in this code. This code NOT video/audio....., this
code is abstract bus driver, and doesn't fall under some exist kernel
tree node :(.

-- 
Regards
Andrey Volkov
