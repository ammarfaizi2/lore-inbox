Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUFENpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUFENpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 09:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUFENpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 09:45:25 -0400
Received: from 34.69-93-140.reverse.theplanet.com ([69.93.140.34]:951 "EHLO
	andromeda.hostvector.com") by vger.kernel.org with ESMTP
	id S261418AbUFENpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 09:45:16 -0400
Message-ID: <40C1CF41.4050208@nixlab.net>
Date: Sat, 05 Jun 2004 15:48:49 +0200
From: mattia <mattia@nixlab.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040528)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: DriveReady SeekComplete Error
References: <E1BWBjw-0003QZ-1h@andromeda.hostvector.com> <20040604195809.GB15249@bounceswoosh.org>
In-Reply-To: <20040604195809.GB15249@bounceswoosh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - andromeda.hostvector.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - nixlab.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:

>> Jun  4 08:05:43 blink kernel: hdd: task_no_data_intr: status=0x51 {
>> DriveReady SeekComplete Error }
>> Jun  4 08:05:43 blink kernel: hdd: task_no_data_intr: error=0x04 {
>> DriveStatusError }
>> Jun  4 08:05:43 blink kernel: hdd: Write Cache FAILED Flushing!
>
>
> That is a known issue in older driver versions that should be resolved
> now.  It only affects our latest generation of drives that are <=
> 120GB, it will not affect the larger drives (>= 160GB), and it won't
> affect any drives of the next product generation because I fixed the
> root cause in the drive as well as helping identify a driver
> workaround/fix.
>
> error=0x04 is an "abort" and not a critical error
>
> The original note had error=0x40, which is an Uncorrectable ECC
> error... that is bad, and you should probably RMA the drive.
>
> You can also try to see if you can "fix" it by writing to that LBA
> (obviously backup your data first) and see if the error goes
> away... if that is the case, the ECC could have been due to a write
> splice at power failure or some other transient event (extreme shock
> or heat or something)
>
> If there are a lot of ECC errors (you have them in about 2 places)
> which could be a sign of bad things in progress, just RMA the drive.
>
> --eric
>
>
I use that drive normally, smartctl does not report errors.
That error was not displayed before: I don't remember, but maybe with 
the 2.6.5 kernel (is that possible?) - now i run the 2.6.6

Bye

