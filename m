Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291541AbSBMKsd>; Wed, 13 Feb 2002 05:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291544AbSBMKsP>; Wed, 13 Feb 2002 05:48:15 -0500
Received: from [195.63.194.11] ([195.63.194.11]:13574 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291541AbSBMKsD>; Wed, 13 Feb 2002 05:48:03 -0500
Message-ID: <3C6A4449.3030703@evision-ventures.com>
Date: Wed, 13 Feb 2002 11:47:37 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <3C69750E.8BA2C6AB@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Martin Dalecki wrote:
>
>>If you are already at it, I would like to ask to you consider seriously
>>the removal of the
>>following entries in the ide drivers /proc control files:
>>
>>    ide_add_setting(drive,    "breada_readahead",    ...         1,
>>2,    &read_ahead[major],        NULL);
>>    ide_add_setting(drive,    "file_readahead",   ...
>>&max_readahead[major][minor],    NULL);
>>
>>Those calls can be found in ide-cd.c, ide-disk,c and ide-floppy.c
>>
>
>I suspect that if we remove these, we'll one day end up putting them back.
>It is appropriate that we be able to control readahead characteristics
>on a per-device and per-technology basis.
>
You are missing one simple thing: The removed values doen't control 
ANYTHING!


