Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTKEKKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 05:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbTKEKKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 05:10:35 -0500
Received: from pop.gmx.de ([213.165.64.20]:19407 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262795AbTKEKKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 05:10:33 -0500
X-Authenticated: #4512188
Message-ID: <3FA8CCF9.6070700@gmx.de>
Date: Wed, 05 Nov 2003 11:12:09 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA69CDF.5070908@gmx.de> <20031105084007.GZ1477@suse.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de>
In-Reply-To: <20031105100120.GH1477@suse.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Nov 05 2003, Prakash K. Cheemplavam wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Wed, Nov 05 2003, Prakash K. Cheemplavam wrote:
>>>
>>>
>>>>Jens Axboe wrote:
>>>>
>>>>
>>>>
>>>>>On Mon, Nov 03 2003, Prakash K. Cheemplavam wrote:
>>>>>
>>>>>
>>>>>
>>>>>>Hi,
>>>>>>
>>>>>>well I am using k3b0.10.1 and either choosing cdrdao or cdrecord in 
>>>>
>>>>DAO mode to burn the cd ends up in non-bit identical copies, wheres ion 
>>>>TAO (atleast with my 10x CD-RW I tested) the copy succeded. I tried 
>>>>several times, and always got this issue.
>>>>
>>>>
>>>>>>bash-2.05b$ md5sum livecd-2.6_10-23-2003.iso
>>>>>>f73f3a74239dfe94b322b85fd14a306e livecd-2.6_10-23-2003.iso
>>>>>>
>>>>>>TAO:
>>>>>>bash-2.05b$ md5sum /dev/cdroms/cdrom1
>>>>>>f73f3a74239dfe94b322b85fd14a306e /dev/cdroms/cdrom1
>>>>>>
>>>>>>DAO:
>>>>>>bash-2.05b$ md5sum /dev/cdroms/cdrom1
>>>>>>09e7e2a51af4c64685831513fbac18c2 /dev/cdroms/cdrom1
>>>>>
>>>>>
>>>>>
>>>>>Could you please try and cmp the two images, finding out how big the
>>>>>corrupted chunks are and what kind of data they contain?
>>>>
>>>>
>>>>After some further investigation I found out, that the data is NOT 
>>>>corrupted, but in a way truncated in DAO mode: When I read out the image 
>>>
>>>>from the CD-RW drive, about 5kbyte are missing at the end (and doing 
>>>
>>>>several burn, it is always the same amount). Strange enough if I read 
>>>>the DAO burnt disk out by my DVD-ROM, the image can be read out 
>>>>completely! Can you understand this behaviour? I don't think it is a 
>>>>problem of my burner, but rather of the atapi driver?
>>>
>>>
>>>Is actual data missing at the end? If yes, I'd say this looks a lot more
>>>like a cdrecord problem.
>>
>>Sorry, I wasn't precise: The data is on the disc, as my DVD-ROM restores 
>>the full image (md5sum matches), but the CD-RW does not.
> 
> 
> You need to use the pad option to record.

Uhm, could you be more specific? I just use the k3b frontend to burn, 
and in the cdrdao manual I couldn't find something useful to it.

SOmething else I noticed with new 2.6tes9-mm2 kernel: Now the mouse 
stutters slighty when burning (in atapi mode). I am now using as 
sheduler. Shoudl I try deadline or do you this it is something else? 
Should I open a new topic?

Prakash


