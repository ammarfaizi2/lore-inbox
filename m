Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQJaStz>; Tue, 31 Oct 2000 13:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbQJaStf>; Tue, 31 Oct 2000 13:49:35 -0500
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:20746 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129595AbQJaStU>; Tue, 31 Oct 2000 13:49:20 -0500
Message-ID: <39FF14C9.33AE7325@mvista.com>
Date: Tue, 31 Oct 2000 10:51:53 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Locking question, is this cool?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At line 1073 of ../drivers/char/i2lib.c (2.4.0-test9) we find:

WRITE_LOCK_IRQSAVE(...

this is followed by:

COPY_FROM_USER(...

It seems to me that this could result in a page fault with interrupts
off.  Is this ok?

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
