Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUKHWao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUKHWao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUKHWan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:30:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9999 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261278AbUKHWaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:30:25 -0500
Date: Mon, 8 Nov 2004 23:29:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-os@analogic.com
Cc: Pawe?? Sikora <pluto@pld-linux.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108222952.GJ15077@stusta.de>
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de> <20041108163101.GA13234@stusta.de> <200411081904.13969.pluto@pld-linux.org> <20041108183120.GB15077@stusta.de> <Pine.LNX.4.61.0411081410560.6407@chaos.analogic.com> <20041108212713.GH15077@stusta.de> <Pine.LNX.4.61.0411081640320.8258@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411081640320.8258@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 05:15:14PM -0500, linux-os wrote:
> >...
> >Are you using exactly my example file?
> >Are you using the complete gcc command line as shown by "make V=1"?
> >Which gcc 3.3.3 are you using?
> >
> 
> No, I am using (no headers):
> -------------------
> extern int sprintf(char *, const char *,...);
> extern int puts(const char *);
> static const char hello[]="Hello";
> int xxx(void);
> int xxx(){
>    char buf[0x100];
>    sprintf(buf, "%s", hello);
>    puts(buf);
>    return 0;
> }
> --------------------
> 
> Compiled as:
> 
> gcc -O2 -Wall -S -o xxx xxx.c
>...

If you don't compile the code as it would be compiled inside the kernel, 
that's your fault...

Please reply only if you can reproduce this with
#include <linux/string.h>, #include <linux/kernel.h> _and_ a gcc command
line as it would be in the kernel - everything else is useless.

> Cheers,
> Dick Johnson

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

