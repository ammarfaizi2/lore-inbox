Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRA3WDO>; Tue, 30 Jan 2001 17:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132583AbRA3WCz>; Tue, 30 Jan 2001 17:02:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16000 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132556AbRA3WCq>; Tue, 30 Jan 2001 17:02:46 -0500
Date: Tue, 30 Jan 2001 17:01:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: I Lee Hetherington <ilh@sls.lcs.mit.edu>
cc: Vaidy Sunderam <sunderam@cs.utk.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ruined boot sector on X20/W2K
In-Reply-To: <3A773734.BE3D0455@sls.lcs.mit.edu>
Message-ID: <Pine.LNX.3.95.1010130165526.7058A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, I Lee Hetherington wrote:

> If Mandrake used LILO to install, there very well might be a backup in
> /boot/boot.0800 or something like that.  You might want to consult the
> LILO documentation and/or a net search to see if they say how to restore
> this (probably using dd).
> 
> If you have real W2K media, it has boot floppies and a CD.  You can boot
> from floppy to access the CD, and then run recovery mode.  It might be
> able to fix this up.  Then again, it might demand that you had made an
> emergency recovery disk from within W2K, something I learned the hard
> way once.
> 
> --Lee Hetherington
> 

Yes. Just get back up using the floppy boot disk that you must
have made. Then look in /boot. You should see boot.0800. This
is 512k in size. It is the original boot sector. Now, make damn
sure that you know the raw device used to boot the machine!

It is probably /dev/hda if you have IDE drives or /dev/sda if
you have SCSI, just do `od /dev/whatever` and if the Disk drive
LED comes on, you have found it.

Then, simply:
	cp /boot/boot.0800 /dev/whatever

Since boot.0800 is already the correct length, you don't have to
use anything else.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
