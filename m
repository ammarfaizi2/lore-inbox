Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbTF3Vtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbTF3Vtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:49:32 -0400
Received: from miranda.zianet.com ([216.234.192.169]:51729 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S265911AbTF3VtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:49:19 -0400
Message-ID: <3F00ACF2.7020709@zianet.com>
Date: Mon, 30 Jun 2003 15:34:42 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: gilson r <gilsonr@highstream.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.72 doesn't load up
References: <200306301655.06221.gilsonr@highstream.net> <200306302301.42046.m.c.p@wolk-project.de>
In-Reply-To: <200306302301.42046.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps this option should just be set as default and don't
even prompt the user for it during make config/menuconfig/xconfig.
99% of the people probably want this option and for those who
don't probably have the smarts to just manually edit the .config and
remove it.

Steve

Marc-Christian Petersen wrote:

>On Monday 30 June 2003 22:55, gilson r wrote:
>
>Hi Gilson,
>
>  
>
>>Just as when I tried 2.5.64, I get now the same result with 2.5.72.
>>    
>>
>Consider using .73 :)
>
>  
>
>>When I reboot with the new kernel, I get:
>>   "Booting 'Linux-2.5.72'
>>   kernel (hd1,14)/vmlinuz-2.5.72 ro root=/dev/hdb2 hdc=ide-scsi
>> [Linux - bzImage, setup=0x1400, size=0xdd72f]
>>   initrd (hd1,14)/initrd-2.5.72.img
>> [Linux - initrd @ 0xf7cb000, 0x14d14 bytes]
>> Uncompressing Linux... Ok, booting the kernel."
>>And it hangs there, whether I compile with Mandrake-9.1 or RedHat-8.
>>I'd love to learn what I'm doing wrong.
>>    
>>
>Well, does it _really_ hang or are you able to ping that machine from another 
>machine? Your error looks like the 8435989 times discussed misconfiguration 
>;)
>
>CONFIG_INPUT=y
>CONFIG_VT=y
>CONFIG_VT_CONSOLE=y
>
>Make sure you have the above set in your .config
>
>Or, to speak in menuconfig language:
>
>Input device support ->
> [*] Input devices (needed for keyboard, mouse, ...)
>Character devices ->
> [*] Virtual terminal
>    [*] Support for console on virtual terminal
>
>
>ciao, Marc
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


