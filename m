Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263073AbSJBMkv>; Wed, 2 Oct 2002 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbSJBMkv>; Wed, 2 Oct 2002 08:40:51 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1295 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263073AbSJBMku>;
	Wed, 2 Oct 2002 08:40:50 -0400
Date: Wed, 2 Oct 2002 14:44:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Frederik Nosi <fredi@e-salute.it>
Cc: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: make menuconfig error
Message-ID: <20021002144444.A1369@mars.ravnborg.org>
Mail-Followup-To: Frederik Nosi <fredi@e-salute.it>, mec@shout.net,
	linux-kernel@vger.kernel.org
References: <200210021403.00305.fredi@e-salute.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210021403.00305.fredi@e-salute.it>; from fredi@e-salute.it on Wed, Oct 02, 2002 at 02:03:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 02:03:00PM +0200, Frederik Nosi wrote:
> Please CC me because I'm not in the list
> Here it is:
> 
> 
> Menuconfig has encountered a possible error in one of the kernel's
> configuration files and is unable to continue.  Here is the error
> report:
> 
>  Q> ./scripts/Menuconfig: MCmenu74: command not found
> 
> Please report this to the maintainer <mec@shout.net>.  You may also
> send a problem report to <linux-kernel@vger.kernel.org>.
> 
> Please indicate the kernel version you are trying to configure and
> which menu you were trying to enter when this error occurred.
> 
> make: *** [menuconfig] Error 1
There is something wrong in the ALSA Config.in, fix already posted.
See http://marc.theaimsgroup.com?l=linux-kernel

> 
> 
> Another strangeness: Some drivers do not build and finding the errors is 
> difficult because the error messages come only during linking. When I build 
> the kernel usually run this command:
> 
> make (bzImage | modules) 2> /some/file .
> 
> During compiling i haven't get any compile error, this seems as the linker 
> goes searching for files not compiled:
> 
> ld: cannot open ircomm_tty.o: No such file or directory
> make[3]: *** [ircomm-tty.o] Error 1
> make[2]: *** [ircomm] Error 2
> make[1]: *** [irda] Error 2
> make: *** [net] Error 2
An error happened when compiling ircomm-tty or one of the composite objects.
Try using:
make KBUILD_VERBOSE=0
Then you will see the error.

Fix already posted to lkml, and present in Linus's latest BK tree.

	Sam
> 
> 
> Cheers,
> Frederik Nosi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
