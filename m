Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWGFWnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWGFWnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWGFWnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:43:17 -0400
Received: from smtp3.cc.ksu.edu ([129.130.7.17]:8115 "EHLO smtp3.cc.ksu.edu")
	by vger.kernel.org with ESMTP id S1750970AbWGFWnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:43:16 -0400
Message-ID: <44AD9229.6010301@ksu.edu>
Date: Thu, 06 Jul 2006 17:43:53 -0500
From: "Scott J. Harmon" <harmon@ksu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060601)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.17.4
References: <20060706222704.GB2946@kroah.com> <20060706222841.GD2946@kroah.com>
In-Reply-To: <20060706222841.GD2946@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> diff --git a/Makefile b/Makefile
> index 8c72521..abcf2d7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
>  VERSION = 2
>  PATCHLEVEL = 6
>  SUBLEVEL = 17
> -EXTRAVERSION = .3
> +EXTRAVERSION = .4
>  NAME=Crazed Snow-Weasel
>  
>  # *DOCUMENTATION*
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 0b6ec0e..59273f7 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1991,7 +1991,7 @@ asmlinkage long sys_prctl(int option, un
>  			error = current->mm->dumpable;
>  			break;
>  		case PR_SET_DUMPABLE:
> -			if (arg2 < 0 || arg2 > 2) {
> +			if (arg2 < 0 || arg2 > 1) {
>  				error = -EINVAL;
>  				break;
>  			}
Just curious as to why this isn't just
...
			if (arg2 != 1) {
...

Thanks,

Scott.
