Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268427AbRHCKNo>; Fri, 3 Aug 2001 06:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268537AbRHCKNf>; Fri, 3 Aug 2001 06:13:35 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:58785 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268427AbRHCKNW>; Fri, 3 Aug 2001 06:13:22 -0400
Message-ID: <3B6A7A72.C2BF8C26@veritas.com>
Date: Fri, 03 Aug 2001 15:48:26 +0530
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sujal Shah <sujal@sujal.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tigran@veritas.com
Subject: Re: FS Development (or interrupting ls)
In-Reply-To: <3B69EF9C.74DF18D6@sujal.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian had a patch for doing a forced unmount.
It will solve your problem.
You can check whether he has a patch for the kernel you 
are using.

Sujal Shah wrote:
> 
> I'm working on a userspace filesystem daemon which replaces Venus (from
> CODA) or podfuk (UserVFS) using the CODA driver.  I'm still early in my
> development process, but I've run into one frustrating problem.  While
> testing my code, I have started causing ls to hang.
> 
> It keeps the directory open, which means I can't do things like, oh,
> unmount the filesystem. :-)  Anyone have any suggestions on recovering
> gracefully when this happens short of rebooting (which is what I do
> now)?  Basically, 'ls' hangs, and can't be killed (even kill -9) and
> 'lsof' lists the directory as open (which is furthered confirmed by
> umount complaining about the filesystem being busy).
> 
> Thanks,
> 
> Sujal
> 
> --
> ------ Sujal Shah ---- sujal@sujal.net
> 
>            http://www.sujal.net/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Amit Kale
Veritas Software ( http://www.veritas.com )
