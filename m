Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVBVVGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVBVVGS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVBVVGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:06:18 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:8916 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261245AbVBVVGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:06:13 -0500
Message-ID: <421B9FD8.6030000@tmr.com>
Date: Tue, 22 Feb 2005 16:10:48 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX
 as device
References: <1108998023.15518.93.camel@localhost.localdomain><200502152125.j1FLPSvq024249@turing-police.cc.vt.edu> <58cb370e0502210725520eee3@mail.gmail.com>
In-Reply-To: <58cb370e0502210725520eee3@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On Mon, 21 Feb 2005 15:00:28 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
>>On Gwe, 2005-02-18 at 10:31, Kiniger, Karl (GE Healthcare) wrote:
>>
>>>Not entirely true (at least for me). I actually tried to read the
>>>last iso9660 data sector with a small C program (reading 2 kb) and
>>>it failed to read the sector. Using ide-scsi I was able to read it.....
>>
>>Thats the bug that should now be fixed by the ide changes I did so that
>>ide-cd has the knowledge ide-scsi has for partial completions of I/O
> 
> 
> I haven't looked closely but I've noticed that these fixes are accessing rq->bio
> directly which is a layering violation.  Could you de-bio and submit them?
> [ AFAIR they are already splitted out in RHEL4 ]
> 
> Speaking about ide-scsi, it will be undeprecated after I fix the locking.
> Rationale is that ide-scsi is _much_ simpler than ide-{cd,tape}.
> [ although it doesn't support all the hardware that ide-{cd,tape} do ]

Some time ago I offered the opinion that this was the correct way to go. 
  Linux presents real SCSI, PPA, USB, and firewire as SCSI, and with 
ide-scsi all ATAPI devices are covered as well.

I have not tried ide-floppy in some time, but my two machines which do 
ZIP drive media exchange both use the ide-scsi interface and 2.4 kernel 
to talk to the devices. They are unlikely to get or need an update, but 
I did try ide-floppy at one time and had some poorly-remembered 
"learning experience" doing so.

Thanks for your work on this!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
