Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRA2S1U>; Mon, 29 Jan 2001 13:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131249AbRA2S1L>; Mon, 29 Jan 2001 13:27:11 -0500
Received: from web121.mail.yahoo.com ([205.180.60.129]:25873 "HELO
	web121.yahoomail.com") by vger.kernel.org with SMTP
	id <S131127AbRA2S0x>; Mon, 29 Jan 2001 13:26:53 -0500
Message-ID: <20010129182651.20462.qmail@web121.yahoomail.com>
Date: Mon, 29 Jan 2001 10:26:51 -0800 (PST)
From: Paul Powell <moloch16@yahoo.com>
Subject: Forcefully eject CD-ROM
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to eject my bootable CD-ROM after the user
is finished using it.  The problem is that something
has locked the CD-ROM and every command I send fails
with a "resource busy" error.

I use a custom init program to mount and chroot to the
CD.  I then start X-windows and my application.  When
the application quits I send SIGTERM signals to
X-windows and the other processes I spawned for them
to shutdown as well.  I then try to unmount and eject
the CD but I am not able to do so.

If I don't start the GUI then I can umount and eject
the CD with no problems.  Nothing is different except
I didn't fork the X process.  But if I start the GUI
and then kill the GUI I can't unmount and eject the
CD.  It's as if X-windows is still using the CD even
though I killed it with the SEGTERM signal.

Is there a way to tell the CD to unmount and eject
regardless of what Linux thinks is the 'proper' thing
to do?  Am I killing the GUI wrong?

Thanks

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices. 
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
