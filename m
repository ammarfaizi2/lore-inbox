Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUIXAhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUIXAhw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUIXAhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:37:38 -0400
Received: from maceio.ic.unicamp.br ([143.106.7.31]:50346 "EHLO
	maceio.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S267657AbUIXAgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:36:52 -0400
Subject: Re: PATCH: tty locking for 2.6.9rc2
From: Ulisses <ra993482@ic.unicamp.br>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1095986215.23984.8.camel@malazarte.lsd.ic.unicamp.br>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Sep 2004 21:36:56 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ ... ]

+++ linux-2.6.9rc2/drivers/char/rocket.c	2004-09-14 14:29:10.284530328 +0100

[ ... ]

-	space = tty->ldisc.receive_room(tty);
+	if (ld)
+		space = tty->ldisc.receive_room(tty);
                        ^^^
Alan,

	It's supposed to be 'ld->receive_room(tty)', isn't it? :-)

Regards,

-- Ulisses


