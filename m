Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291558AbSBMK4n>; Wed, 13 Feb 2002 05:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291555AbSBMK4d>; Wed, 13 Feb 2002 05:56:33 -0500
Received: from [195.63.194.11] ([195.63.194.11]:22790 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291545AbSBMK4Z>; Wed, 13 Feb 2002 05:56:25 -0500
Message-ID: <3C6A4649.3000606@evision-ventures.com>
Date: Wed, 13 Feb 2002 11:56:09 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@norran.net>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <200202121922.g1CJMPi23466@mailc.telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:

>On Tuesday den 12 February 2002 11.52, Martin Dalecki wrote:
>
>>If you are already at it, I would like to ask to you consider seriously
>>the removal of the
>>following entries in the ide drivers /proc control files:
>>
>>[snip]
>>    ide_add_setting(drive,    "file_readahead",   ...
>>&max_readahead[major][minor],    NULL);
>>
>>Those calls can be found in ide-cd.c, ide-disk,c and ide-floppy.c
>>
>>[snip]
>>
>>The second of them is trying to control a file-system level constant
>>inside the actual block device driver.
>>This is a blatant violation of the layering principle in software
>>design, and should go as soon as
>>possible.
>>
>
>It really should go (the only one working is for ide-disk) but
>you need to add another way to tune readahead per disk too...
>
>Tuning this parameter gives quite a bit improved performance
>when reading from several big files at a time! A diff of two big files
>is enough to show it: from 10MB/s to 25MB/s (2.4.17-rc1)
>(due to less time lost seeking)
>

We are talking about 2.5.xx. In 2.5.xx the removed parameters just don't 
change anything and are simple
code garbage.



