Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132468AbRBEAUJ>; Sun, 4 Feb 2001 19:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbRBEAT7>; Sun, 4 Feb 2001 19:19:59 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:30377 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132468AbRBEATv>; Sun, 4 Feb 2001 19:19:51 -0500
Message-ID: <3A7DF190.C0A3BE83@mail.com>
Date: Sun, 04 Feb 2001 19:19:28 -0500
From: Thomas Hood <jdthoodREMOVETHIS@mail.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] Shutting down PCMCIA driver in Linux 2.4.1, "Trying to free 
 nonexistent resource <000003e0-000003e1>"
In-Reply-To: <393D1B6D.ECCE0721@mail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this message when shutting down Linux with 2.4.1 kernel,
kernel PCMCIA support compiled as a module.

---------------------------------------------------------------------------------

$ cat /proc/ioports
...
03e0-03e1 : i82365
...
$ sudo reboot
(reboot)
$ grep 3e0 /var/log/messages
Feb  4 18:13:44 thanatos kernel: Trying to free nonexistent resource <000003e0-000003e1>

----------------------------------------------------------------------------------

IIRC, during the shutdown sequences the "Trying ..." message appears just
after the words "Shutting down PCMCIA card services: cardmgr modules".

T. Hood
jdthood_AT_mail.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
