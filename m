Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbRCHOPL>; Thu, 8 Mar 2001 09:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130043AbRCHOPB>; Thu, 8 Mar 2001 09:15:01 -0500
Received: from [213.203.46.68] ([213.203.46.68]:43528 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130029AbRCHOOy>; Thu, 8 Mar 2001 09:14:54 -0500
To: "Jie Zhou" <jiezhou@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 kernel mount crash
In-Reply-To: <OF586830F9.6A70047B-ON85256A09.004D1EC7@somers.hqregion.ibm.com>
From: remco@solbors.no (Remco B. Brink)
Organization: Norge-iNvest <http://www.norge-invest.no>
Date: 08 Mar 2001 15:13:34 +0100
In-Reply-To: <OF586830F9.6A70047B-ON85256A09.004D1EC7@somers.hqregion.ibm.com> ("Jie Zhou"'s message of "Thu, 8 Mar 2001 09:03:27 -0500")
Message-ID: <m3itlkuz5d.fsf@localhost.localdomain>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jie Zhou" <jiezhou@us.ibm.com> writes:
> I did an upgrade from  kernel-2.2.16 to the latest version-2.4.2.
> During the "make bzImage"step, I got bunch of this warning:
> "pasting would not give a valid preprocessing token". then I just ignored
> it and after all done rebooted the linux and got into the new kernel successfully. 

The above message is related to the version of gcc that you get with
your copy of RedHat7. You might just want to use kgcc instead of gcc
to compile your kernel.

> However, when I tried to mount my DVD RAM using the command mount -t udf /dev/hdb /mnt/dvd
> (I did choose the support for udf filesystem), the command completed with a
> promp appears.but after the 'busy' light on the DVD catridge gets on, it never gets off any
> more, and the computer froze then. I thought it might be because I haven't unmount
> the DVD , so I restarted the computer and use the 'dmesg' command to see what
> happens, then I found a lot of "Unable to identify CD-ROM Format" messages in it. so I did a 'mount'
> command to check whether it's mounted or not, and the result shows that the /dev/hdb(which is the DVD on
> my computer) is not mounted yet.

Same problem here, albeit not with a DVD drive.

After mounting anything with the loopback device (I know it's not working
that well in 2.4.2) all future mounts of my SCSI writer and SCSI cdrom don't 
even return a prompt. The mount just 'hangs' and the mount process can't be killed 
either.

> So I did the mount -t udf /dev/hdb /mnt/dvd again, same thing happens
> again-the computer froze with the DVD light on.
> I read in the book "Running Linux", the author said
> "If any errors or warnings occur while compiling, you cannot expect the
> resulting kernel to work correctly..." I'm wondering if it's because of the the
> warning I got during the process of compiling the image file-"pasting would not give a valid
> preprocessing token" that the mount command fails.

No, probably not.

I used kgcc to compile the kernel, did not get any of the RH7 gcc warning messages
and still am left with a not-so-stable mount.

> Any kind of suggestions are appreciated..

Very much appreciated even ;)

regards,
Remco

-- 
Remco B. Brink                                  Norge-iNvest AS
Kung foo                            http://www.norge-invest.com
        PGP/GnuPG key at http://remco.xgov.net/rbb.pgp

panic("Oh boy, that early out of memory?");
	2.2.16 /usr/src/linux/arch/mips/mm/init.c
