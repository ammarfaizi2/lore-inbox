Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290017AbSBMNJk>; Wed, 13 Feb 2002 08:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSBMNJY>; Wed, 13 Feb 2002 08:09:24 -0500
Received: from [195.63.194.11] ([195.63.194.11]:61191 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287764AbSBMNJT>; Wed, 13 Feb 2002 08:09:19 -0500
Message-ID: <3C6A6571.7070707@evision-ventures.com>
Date: Wed, 13 Feb 2002 14:09:05 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] queue barrier support
In-Reply-To: <20020213135134.A1907@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>Patches attached, comments welcome.
>
>diff -Nru a/include/linux/ide.h b/include/linux/ide.h
>--- a/include/linux/ide.h	Wed Feb 13 13:48:25 2002
>+++ b/include/linux/ide.h	Wed Feb 13 13:48:25 2002
>@@ -448,6 +448,7 @@
> 	byte		acoustic;	/* acoustic management */
> 	unsigned int	failures;	/* current failure count */
> 	unsigned int	max_failures;	/* maximum allowed failure count */
>+	char		special_buf[4];	/* IDE_DRIVE_CMD, free use */
> } ide_drive_t;
>
ide-barrier-1-c1.296:+  memset(drive->special_buf, 0, 
sizeof(drive->special_buf));
ide-barrier-1-c1.296:+  flush_rq->buffer = drive->special_buf;
ide-barrier-1-c1.296:+  char            special_buf[4]; /* 
IDE_DRIVE_CMD, free use */

I just don't see special_buf used anywhere. What is it supposed to be 
used for?
Is the intention to make it look like the SCSI code?

>


