Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277711AbRJIEFs>; Tue, 9 Oct 2001 00:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277709AbRJIEFi>; Tue, 9 Oct 2001 00:05:38 -0400
Received: from web13606.mail.yahoo.com ([216.136.175.117]:57864 "HELO
	web13606.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277711AbRJIEFV>; Tue, 9 Oct 2001 00:05:21 -0400
Message-ID: <20011009040551.34486.qmail@web13606.mail.yahoo.com>
Date: Mon, 8 Oct 2001 21:05:51 -0700 (PDT)
From: Todd Roy <todd_m_roy@yahoo.com>
Subject: jbd_preclean_buffer_check.
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        Andrew Morton <andrewm@uow.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is old guys, but I just noticed
that modules loop.o and md.o are broken in at least
2.4.10-ac9
and ac10, if  CONFIG_EXT3_FS=Y, JBD_CONFIG=Y and
CONFIG_JBD_DEBUG=Y:

typical modprobe output:
/lib/modules/2.4.10-ac10/kernel/drivers/md/md.o:
unresolved symbol jbd_preclean_buffer_check
/lib/modules/2.4.10-ac10/kernel/drivers/md/md.o:
insmod /lib/modules/2.4.10-ac10/kernel/drivers/md/md.o
failed
/lib/modules/2.4.10-ac10/kernel/drivers/md/md.o:
insmod md failed
/lib/modules/2.4.10-ac10/kernel/drivers/block/loop.o:
unresolved symbol jbd_preclean_buffer_check
/lib/modules/2.4.10-ac10/kernel/drivers/block/loop.o:
insmod
/lib/modules/2.4.10-ac10/kernel/drivers/block/loop.o
failed
/lib/modules/2.4.10-ac10/kernel/drivers/block/loop.o:
insmod loop failed

I am recompiling now to see if turning off JBD_DEBUG
will fix things.
Usually at times like this I just (blindly) add an
entry to kernel/ksyms.c but that doesn't seem to work.
Thanks,
-- todd --

__________________________________________________
Do You Yahoo!?
NEW from Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
