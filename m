Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUKCWFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUKCWFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbUKCWEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:04:39 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:38785 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261930AbUKCWAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:00:11 -0500
Message-ID: <41895583.10604@tmr.com>
Date: Wed, 03 Nov 2004 17:02:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 USB storage problems
References: <200410121424.59584.worf@sbox.tu-graz.ac.at> <20041101164615.13a04a7c@lembas.zaitcev.lan>
In-Reply-To: <20041101164615.13a04a7c@lembas.zaitcev.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> On Mon, 1 Nov 2004 23:19:13 +0100, Wolfgang Scheicher <worf@sbox.tu-graz.ac.at> wrote:
> 
> 
>>>>And: could maybe somebody put some hints into the ub help?
>>>>"This driver supports certain USB attached storage devices such as flash
>>>>keys." didn't sound so bad to me...
>>>
>>>That should definately happen.  Along with a note that this blocks
>>>usb-storage from working with many devices if enabled.
>>
>>Yep. Absolutely.
> 
> 
> I don't like too much wordage. How about this:
> 
> diff -urp -X dontdiff linux-2.6.10-rc1/drivers/block/Kconfig linux-2.6.10-rc1-ub/drivers/block/Kconfig
> --- linux-2.6.10-rc1/drivers/block/Kconfig	2004-10-28 09:46:38.000000000 -0700
> +++ linux-2.6.10-rc1-ub/drivers/block/Kconfig	2004-11-01 16:09:13.727453544 -0800
> @@ -308,6 +308,8 @@ config BLK_DEV_UB
>  	  This driver supports certain USB attached storage devices
>  	  such as flash keys.
>  
> +	  Warning: Enabling this cripples the usb-storage driver.
> +
>  	  If unsure, say N.
>  
>  config BLK_DEV_RAM

I just got information on this in another thread, in case you didn't see 
my note there, is this behaviour a bug, design choice, or unavoidable 
hardware issue? I can turn it off now, but I'm supposed to be getting a 
flash key thing to test, which is why I turned it on in the first place.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
