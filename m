Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263283AbSJ1Lbv>; Mon, 28 Oct 2002 06:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263289AbSJ1Lbv>; Mon, 28 Oct 2002 06:31:51 -0500
Received: from mx0.gmx.net ([213.165.64.100]:30557 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S263283AbSJ1Lbv>;
	Mon, 28 Oct 2002 06:31:51 -0500
Date: Mon, 28 Oct 2002 12:38:05 +0100 (MET)
From: Norbert Rooss <zaeld@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: tty drivers: Is put_char mandatory?
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0004530950@gmx.net
X-Authenticated-IP: [62.8.145.242]
Message-ID: <11192.1035805085@www42.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

Simple question: Is the implementation of the function put_char() for tty
drivers mandatory? (Defined in include/linux/tty_driver.h, struct tty_driver)

Because if it is not, then there is a bug in drivers/char/n_tty.c, where the
driver specific put_char gets called without a check for availability (in
function opost())

On the other hand, if it is mandatory, then there is a bug in the USB serial
part, as usbserial.c does not implement put_char()...
(drivers/usb/serial/usbserial.c)

bye
Norbert

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!

