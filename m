Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291007AbSBLMu4>; Tue, 12 Feb 2002 07:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291014AbSBLMuq>; Tue, 12 Feb 2002 07:50:46 -0500
Received: from [195.63.194.11] ([195.63.194.11]:65292 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291007AbSBLMuf>; Tue, 12 Feb 2002 07:50:35 -0500
Message-ID: <3C690F8E.5010607@evision-ventures.com>
Date: Tue, 12 Feb 2002 13:50:22 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>------------------------------------------------------------------------
>
>diff -urN linux-2.5.4/drivers/ide/ide-cd.c linux-2.5.4-ideclean/drivers/ide/ide-cd.c
>--- linux-2.5.4/drivers/ide/ide-cd.c	Thu Jan 31 16:45:20 2002
>+++ linux-2.5.4-ideclean/drivers/ide/ide-cd.c	Tue Feb 12 12:34:48 2002
>@@ -2662,8 +2662,6 @@
> 	int major = HWIF(drive)->major;
> 	int minor = drive->select.b.unit << PARTN_BITS;
> 
>
Please note that the two line above can be killed then as well. More 
recent gcc version
report this now as unused.



