Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314630AbSD0Woa>; Sat, 27 Apr 2002 18:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSD0Woa>; Sat, 27 Apr 2002 18:44:30 -0400
Received: from [195.63.194.11] ([195.63.194.11]:2321 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314630AbSD0Wo3>;
	Sat, 27 Apr 2002 18:44:29 -0400
Message-ID: <3CCB1B20.8050202@evision-ventures.com>
Date: Sat, 27 Apr 2002 23:41:52 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Douglas Gilbert <dougg@torque.net>
CC: linux-kernel@vger.kernel.org, axboe@suse.de, Dave Jones <davej@suse.de>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ide-scsi 2.5.10-dj1 compilation failure
In-Reply-To: <3CCB22BB.BA6BDFF6@torque.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Douglas Gilbert napisa?:
> Christoph Lameter <christoph@lameter.com> reported this
> compile error in lk 2.5.10-dj1:
> 
>>ide-scsi.c:837: unknown field `abort' specified in initializer
>>ide-scsi.c:837: warning: initialization from incompatible pointer type
>>ide-scsi.c:838: unknown field `reset' specified in initializer
>>ide-scsi.c:838: warning: initialization from incompatible pointer type
> 
> 
> Below is a patch which attempts to do the right thing:
> it wires up the scsi new eh handling and attempts to do
> a device reset.
> 
> It has been tested and oopses in start_request() inside
> ide.c when a device reset is issued :-) Since the previous
> ide-scsi logic just ignored scsi error handling, it isn't
> really a whole lot worse. There is a "fix me" at the
> appropriate point.
> 
> Doug Gilbert


Well the "hidden" queueing of some commands on the
device request queue is what is getting you here. It's subject
to be gone, so this problem will be resolved.

