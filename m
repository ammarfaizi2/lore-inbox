Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292331AbSBPJiy>; Sat, 16 Feb 2002 04:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292332AbSBPJio>; Sat, 16 Feb 2002 04:38:44 -0500
Received: from [195.63.194.11] ([195.63.194.11]:15631 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292331AbSBPJij>; Sat, 16 Feb 2002 04:38:39 -0500
Message-ID: <3C6E2886.8070600@evision-ventures.com>
Date: Sat, 16 Feb 2002 10:38:14 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Vojtech Pavlik <vojtech@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: IDE cleanup for 2.5.4-pre3
In-Reply-To: <20020208231346.GA1209@elf.ucw.cz> <20020211094230.E1957@suse.de> <20020211134443.GC20854@atrey.karlin.mff.cuni.cz> <20020211181013.K729@suse.de> <20020213225326.A10409@suse.cz> <20020214094046.B37@toy.ucw.cz> <3C6CC19C.3040608@evision-ventures.com> <20020215204510.GD5019@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>>It seems bigger as it is at first glance, however if you start to read 
>>it at ide.h, the rest should
>>be, well,  obivous...
>>
>
>Ouch, its *big*. You should probably start pushing it to Jens ASAP,
>because if you'll clean up it a bit more, you'll end with really big
>patch which rewrites whole drivers/ide... [Not that it would be a bad
>thing.]
>

Well the atomic part of the patch is rather small if you look at it. But 
in hell unfortunately there is
no way around to make the consequences smaller. I would be much happier 
if it could be
done otherway around... but I see no way if one want's to preserve the 
drivers in a functional state.

>My favourite cleanup would be 
>
>struct ide_drive_s {} ide_drive_t;
>
>=>
>
>struct ide_drive {};
>
>and replacing all ide_drive_t with struct ide_drive...
>

That will happen.



