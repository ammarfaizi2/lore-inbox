Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRKSIdS>; Mon, 19 Nov 2001 03:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRKSIdJ>; Mon, 19 Nov 2001 03:33:09 -0500
Received: from alex.intersurf.net ([216.115.129.11]:3601 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S274368AbRKSIc6>; Mon, 19 Nov 2001 03:32:58 -0500
Date: Mon, 19 Nov 2001 02:32:58 -0600
From: Mark Orr <markorr@intersurf.com>
To: linux-kernel@vger.kernel.org
Subject: [2.4.15pre6] Funny error on "make modules_install" - cosmetic cleanup probably needed
Message-Id: <20011119023258.4bb705b0.markorr@intersurf.com>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.4.15-pre6 here, and for several previous
versions there's been an unusual (but harmless) error message
when installing modules via "make modules_install" once the
kernel build is done.

looks like this:

make[2]: Entering directory `/usr/src/linux/drivers/cdrom'
mkdir -p /lib/modules/2.4.15-pre6/kernel/drivers/cdrom/
cp cdrom.o cdrom.o /lib/modules/2.4.15-pre6/kernel/drivers/cdrom/
cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/cdrom/cdrom.o' with `cdrom.o'
make[2]: *** [_modinst__] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/cdrom'
make[1]: *** [_modinst_cdrom] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_modinst_drivers] Error 2

...As I say, it's harmless.  cdrom.o is getting installed, and
you can just make -i ... to get past it.

I'm guessing that I'm the only one getting this error (since I
cant find any other complaints about it)  because i'm using the
latest fileutils v4.1.1 off alpha.gnu.org, which must have code
to complain about such things -- but still, that

cp cdrom.o cdrom.o  /big/long/directory

...just looks weird.  Somebody leave something hanging in
one of the makefiles?

--
Mark Orr
markorr@intersurf.com


