Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTELVOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbTELVOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:14:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:65481 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262737AbTELVO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:14:29 -0400
Date: Mon, 12 May 2003 23:27:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       marcelo <marcelo@conectiva.com.br>
Subject: Re: [PATCH] kbuild and CONFIG_PROC_FS bug
Message-ID: <20030512212704.GX1107@fs.tum.de>
References: <3EBDA545.4010603@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBDA545.4010603@wanadoo.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 03:20:05AM +0200, Xose Vazquez Perez wrote:
> hi guys,
> 
> There is a general error in some files, this was discussed  time
> ago: http://marc.theaimsgroup.com/?l=linux-kernel&m=104948738901849&w=2
> Roman Zippel had a better solution than mine. And here it goes a
> patch for 2.4.21-rc2:
> 
> --cut--
> diff -Nuar linux/arch/alpha/config.in linux.xose/arch/alpha/config.in
> --- linux/arch/alpha/config.in  2003-05-11 02:53:23.000000000 +0200
> +++ linux.xose/arch/alpha/config.in     2003-05-11 02:59:04.000000000 +0200
> @@ -287,7 +287,7 @@
>  bool 'System V IPC' CONFIG_SYSVIPC
>  bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
>  bool 'Sysctl support' CONFIG_SYSCTL
> -if [ "$CONFIG_PROC_FS" = "y" ]; then
> +if [ "$CONFIG_PROC_FS" != "n" ]; then
>...

CONFIG_PROC_FS is a bool, I don't see anything that changes with your 
patch.

> regards,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

