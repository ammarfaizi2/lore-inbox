Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKOUww>; Wed, 15 Nov 2000 15:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129189AbQKOUwm>; Wed, 15 Nov 2000 15:52:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63363 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129150AbQKOUwe>; Wed, 15 Nov 2000 15:52:34 -0500
Date: Wed, 15 Nov 2000 15:15:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: James Stevenson <mistral@stev.org>
cc: mike@flyn.org, linux-kernel@vger.kernel.org
Subject: Re: EJECT ioctl fails on empty SCSI CD-ROM
In-Reply-To: <200011152008.UAA20801@linux.home>
Message-ID: <Pine.LNX.3.95.1001115151153.15581A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000, James Stevenson wrote:

> 
> Hi
> 
> this is what i get on 2.2.17
> 
> open("/dev/scd1", O_RDONLY|O_NONBLOCK)  = 3
> ioctl(3, CDROMEJECT, 0xbffffc78)        = 0
> close(3)                                = 0
> 
> 

> 
> In local.linux-kernel-list, you wrote:
> >Apparently using the CDROMEJECT ioctl with kernel 2.4-testX fails on
> >a SCSI CD-ROM that does not have a disc in it.  The errno returned
> >corresponds to the string ``No such file or directory.''
> >
> >The Linux CD-ROM Standard states that CDROMEJECT opens the drive tray.
> >It does not mention any prerequisite such as media being present.
> >
> >Is this the expected behavior?  If so, I am curious to hear the rationale
> >behind it.
> 

Well the open fails with ENOMEDIUM (errno 123). This is hardly appropriate
since you can't insert any "media" on some machines without a paperclip.

readlink("/dev/cdrom", "", 256)         = 9
open("/dev/scd0", O_RDONLY)             = -1 ERRNO_123 (errno 123)



Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
