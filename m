Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSDWJAn>; Tue, 23 Apr 2002 05:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315123AbSDWJAm>; Tue, 23 Apr 2002 05:00:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:524 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S315119AbSDWJAl>;
	Tue, 23 Apr 2002 05:00:41 -0400
Message-ID: <3CC5140B.5010001@evision-ventures.com>
Date: Tue, 23 Apr 2002 09:58:03 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Douglas Gilbert <dougg@torque.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.9 IDE subsystem oops on scsi box
In-Reply-To: <3CC4DDFA.4632C43A@torque.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> In lk 2.5.9 building a kernel with the ide subsystem and
> ide-disk built in but no ATA disks oopses around mount
> time (of the scsi disk) in the boot sequence.
> 
> This worked fine in lk 2.5.8 and lk 2.5.8-dj1 . Going into
> the BIOS and disabling the on board IDE chipsets makes the
> oops go away:
> $ uname -a
> Linux frig 2.5.9 #21 Mon Apr 22 20:51:46 EDT 2002 i686 unknown
> $ df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/sda3              8499168   6437568   1629856  80% /
> /dev/sda1                31079     16949     12526  58% /boot
> 
> Hand decoding the oops gave this stack backtrace:
>   __ide_end_request
>   ide_end_request
>   ide_intr
>   handle_IRQ
>   do_IRQ
>   default_idle
> 

I will have to check whatever the tagged command queue get's initialized properl
during module loading. Propably not :-(.

