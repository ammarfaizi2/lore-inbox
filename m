Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131948AbRAaO4M>; Wed, 31 Jan 2001 09:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRAaO4C>; Wed, 31 Jan 2001 09:56:02 -0500
Received: from staff0130.dada.it ([195.110.97.130]:62090 "EHLO
	blacksheep.at.dada.it") by vger.kernel.org with ESMTP
	id <S131948AbRAaOzy>; Wed, 31 Jan 2001 09:55:54 -0500
Date: Wed, 31 Jan 2001 15:48:53 +0100 (CET)
From: Patrizio Bruno <patrizio@dada.it>
To: Paul Powell <moloch16@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why isn't init PID 1?
In-Reply-To: <20010131144038.26689.qmail@web118.yahoomail.com>
Message-ID: <Pine.LNX.4.10.10101311547380.3588-100000@blacksheep.at.dada.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, in this situation "sash" is the process with pid '1', you should run this script through init and not viceversa, the first process launched takes pid 1.

P.

On Wed, 31 Jan 2001, Paul Powell wrote:

> Hello,
> 
> I have a bootable linux CD that runs a custom init. 
> Under most versions of linux init runs as process ID
> one.  Under my bootable CD, it runs as process ID 15. 
> I need it to run as PID 1 so that I can execute a
> kill(-1,15) without killing init.
> 
> The boot CD uses and initrd image to load drivers. 
> The linuxrc file looks like:
> 
> #!/bin/sash
> 
> aliasall
> 
> echo "Loading aic7xxx module"
> insmod /lib/aic7xxx.o
> echo "Loading ips module"
> insmod /lib/ips.o ips=ioctlsize:512000
> echo "Loading sg module"
> insmod /lib/sg.o
> echo "Loading FAT modules"
> insmod /lib/fat.o
> insmod /lib/vfat.o
> 
> echo "Mounting /proc"
> mount -t proc /proc /proc
> init
> umount /proc
> 
> Does it run as PID 15 because I execute insmod and
> mount before running init?
> 
> Thanks,
> Paul
> 
> __________________________________________________
> Get personalized email addresses from Yahoo! Mail - only $35 
> a year!  http://personal.mail.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

---------------------------------------------------------
Patrizio Bruno
DADA spa / Ed-IT Development Staff
Borgo degli Albizi 37/r
50122 Firenze
Italy
tel +39 05520351
fax +39 0552478143

PGP PublicKey available at: http://www.keyserver.net/en/
---------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
