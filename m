Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292688AbSCINJb>; Sat, 9 Mar 2002 08:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292739AbSCINJW>; Sat, 9 Mar 2002 08:09:22 -0500
Received: from [195.63.194.11] ([195.63.194.11]:28939 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292688AbSCINJL>; Sat, 9 Mar 2002 08:09:11 -0500
Message-ID: <3C8A0937.4050200@evision-ventures.com>
Date: Sat, 09 Mar 2002 14:08:07 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: jason <jasonmc@sympatico.ca>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] ide-scsi compile fix
In-Reply-To: <20020308235852.FAQN13574.tomts7-srv.bellnexxia.net@there>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jason wrote:
> GCC gives an error about an undefined reference to idescsi_init from ide.c when compiling 2.5.6 with ide scsi emulation enabled, this patch corrects the problem.

Tank you for looking after this.
That was a bit too far reaching on my behalf. You are right if
one disables module support.

> 
> --- a/drivers/scsi/ide-scsi.c   Fri Mar  8 17:22:52 2002
> +++ b/drivers/scsi/ide-scsi.c   Fri Mar  8 17:23:00 2002
> @@ -565,7 +565,7 @@
>  /*
>   *     idescsi_init will register the driver for each scsi.
>   */
> -static int idescsi_init(void)
> +int idescsi_init(void)
>  {
>         ide_drive_t *drive;
>         idescsi_scsi_t *scsi;
> 
>

